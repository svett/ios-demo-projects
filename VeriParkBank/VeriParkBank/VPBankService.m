//
//  VPBankService.m
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/4/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import "VPMutableURLRequest.h"
#import "VPBankService.h"
#import "VPUserToken.h"
#import "SMXMLDocument.h"
#import "VPAccount.h"
#import "VPAccountInfo.h"

static NSString *sDoFirstLoginUrl = @"http://veribranchmobiletest.veripark.com/VBWebService/Service.asmx?op=DoFirstLogin";
static NSString *sDoSecondLoginUrl = @"http://veribranchmobiletest.veripark.com/VBWebService/Service.asmx?op=DoSecondLogin";
static NSString *sGetAccountListUrl = @"http://veribranchmobiletest.veripark.com/VBWebService/Service.asmx?op=GetAccountList";
static NSString *sGetAccountInfoUrl = @"http://veribranchmobiletest.veripark.com/VBWebService/Service.asmx?op=GetAccountInfo";

@implementation VPBankService

#pragma mark - Methods

- (VPMutableURLRequest*)soapRequestWithURL:(NSURL*)url message:(NSString*)message
{
    VPMutableURLRequest *request = [VPMutableURLRequest requestWithURL:url];
    [request setHTTPBody: [message dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue: [NSString stringWithFormat:@"%d", [message length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    return request;
}

- (void)authenticateWithUsername:(NSString*)username password:(NSString*)password
{
    static NSString *sSoapEnvelop = @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">\n"
                                    "   <soapenv:Header/>\n"
                                    "   <soapenv:Body>\n"
                                    "       <tem:DoFirstLogin>\n"
                                    "           <tem:request>\n"
                                    "               <tem:Msisdn>?</tem:Msisdn>\n"
                                    "               <tem:TokenID>?</tem:TokenID>\n"
                                    "               <tem:CustomerId>%@</tem:CustomerId>\n"
                                    "               <tem:UserName>%@</tem:UserName>\n"
                                    "               <tem:UserId>%@</tem:UserId>\n"
                                    "               <tem:OperationDate>?</tem:OperationDate>\n"
                                    "               <tem:ChannelType>1</tem:ChannelType>\n"
                                    "               <tem:GenericParameter>?</tem:GenericParameter>\n"
                                    "               <tem:Password>%@</tem:Password>\n"
                                    "           </tem:request>\n"
                                    "       </tem:DoFirstLogin>\n"
                                    "   </soapenv:Body>\n"
                                    "</soapenv:Envelope>\n";
    
    
    NSString *soapMessage = [NSString stringWithFormat:sSoapEnvelop, username, username, username, password];
    
    NSURL *url = [NSURL URLWithString:sDoFirstLoginUrl];
    VPMutableURLRequest *request = [self soapRequestWithURL:url message:soapMessage];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    if(connection)
    {
        request.data = [NSMutableData data];
        request.tag = username;
    }
    else
    {
        NSError *error = [self unnableToEstablishConnectionErrorForUrl:url];
        [self didFailWithError:error];
    }
}

- (NSError*)unnableToEstablishConnectionErrorForUrl:(NSURL*)url
{
    NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSURLErrorKey: url,
                                                                                          NSLocalizedDescriptionKey: @"The connection cannot be established."}];
    return error;
}

- (void)veriftyToken:(VPUserToken*)token password:(NSString*)password
{
    static NSString *sSoapEnvelop = @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">\n"
                                     "  <soapenv:Header/>\n"
                                     "  <soapenv:Body>\n"
                                     "      <tem:DoSecondLogin>\n"
                                     "          <tem:request>\n"
                                     "              <tem:Msisdn>?</tem:Msisdn>\n"
                                     "              <tem:TokenID>%@</tem:TokenID>\n"
                                     "              <tem:CustomerId>%@</tem:CustomerId>\n"
                                     "              <tem:UserName>%@</tem:UserName>\n"
                                     "              <tem:UserId>%@</tem:UserId>"
                                     "              <tem:OperationDate>?</tem:OperationDate>\n"
                                     "              <tem:ChannelType>1</tem:ChannelType>"
                                     "              <tem:GenericParameter>?</tem:GenericParameter>"
                                     "              <tem:Password>%@</tem:Password>"
                                     "           </tem:request>"
                                     "      </tem:DoSecondLogin>"
                                     "  </soapenv:Body>"
                                     "</soapenv:Envelope>";
    
    NSString *soapMessage = [NSString stringWithFormat:sSoapEnvelop, token.tokenId, token.userName, token.userName, token.userName, password];
    
    NSURL *url = [NSURL URLWithString:sDoSecondLoginUrl];
    VPMutableURLRequest *request = [self soapRequestWithURL:url message:soapMessage];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection) {
        request.data = [NSMutableData data];
        request.tag = token;
    }
    else {
        NSError *error = [self unnableToEstablishConnectionErrorForUrl:url];
        [self didFailWithError:error];
    }
}

- (void)accountsForUserToken:(VPUserToken*)token
{
    static NSString *sSoapEnvelop = @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">"
                                     "<soapenv:Header/>\n"
                                     "<soapenv:Body>\n"
                                     "  <tem:GetAccountList>\n"
                                     "      <tem:request>\n"
                                     "          <tem:Msisdn>?</tem:Msisdn>\n"
                                     "          <tem:TokenID>%@</tem:TokenID>\n"
                                     "          <tem:CustomerId>%@</tem:CustomerId>\n"
                                     "          <tem:UserName>%@</tem:UserName>\n"
                                     "          <tem:UserId>%@</tem:UserId>\n"
                                     "          <tem:OperationDate>?</tem:OperationDate>\n"
                                     "          <tem:ChannelType>1</tem:ChannelType>\n"
                                     "          <tem:GenericParameter>?</tem:GenericParameter>\n"
                                     "          <tem:ExecutingTransactionName>?</tem:ExecutingTransactionName>\n"
                                     "          <tem:AccountType>?</tem:AccountType>\n"
                                     "      </tem:request>\n"
                                     "  </tem:GetAccountList>\n"
                                     "</soapenv:Body>\n"
                                     "</soapenv:Envelope>";
    
    NSString *soapMessage = [NSString stringWithFormat:sSoapEnvelop, token.tokenId, token.userName, token.userName, token.userName];
    
    NSURL *url = [NSURL URLWithString:sGetAccountListUrl];
    VPMutableURLRequest *request = [self soapRequestWithURL:url message:soapMessage];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection) {
        request.data = [NSMutableData data];
        request.tag = token;
    }
    else {
        NSError *error = [self unnableToEstablishConnectionErrorForUrl:url];
        [self didFailWithError:error];
    }
}

- (void)infoForAccount:(VPAccount*)account token:(VPUserToken*)token
{
    static NSString *sSoapEnvelop = @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\">\n"
                                     "  <soapenv:Header/>"
                                     "  <soapenv:Body>"
                                     "      <tem:GetAccountInfo>"
                                     "          <tem:request>"
                                     "              <tem:Msisdn>?</tem:Msisdn>"
                                     "              <tem:TokenID>%@</tem:TokenID>"
                                     "              <tem:CustomerId>%@</tem:CustomerId>"
                                     "              <tem:UserName>%@</tem:UserName>"
                                     "              <tem:UserId>%@</tem:UserId>"
                                     "              <tem:OperationDate>?</tem:OperationDate>"
                                     "              <tem:ChannelType>1</tem:ChannelType>"
                                     "              <tem:GenericParameter>?</tem:GenericParameter>"
                                     "              <tem:ExecutingTransactionName>?</tem:ExecutingTransactionName>"
                                     "              <tem:AccountNumber>%@</tem:AccountNumber>"
                                     "              <tem:BranchCode>%@</tem:BranchCode>"
                                     "          </tem:request>"
                                     "      </tem:GetAccountInfo>"
                                     "</soapenv:Body>"
                                     "</soapenv:Envelope>";
    
    NSString *soapMessage = [NSString stringWithFormat:sSoapEnvelop, token.tokenId, token.userName, token.userName, token.userName, account.number, account.branchCode];
    
    NSURL *url = [NSURL URLWithString:sGetAccountInfoUrl];
    VPMutableURLRequest *request = [self soapRequestWithURL:url message:soapMessage];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(connection) {
        request.data = [NSMutableData data];
        request.tag = @[token, account];
    }
    else {
        NSError *error = [self unnableToEstablishConnectionErrorForUrl:url];
        [self didFailWithError:error];
    }
}

- (void)didFailWithError:(NSError*)error
{
    if([self.delegate respondsToSelector:@selector(bankService:didFailWithError:)]) {
        [self.delegate bankService:self didFailWithError:error];
    }
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSURLRequest *request = [connection currentRequest];
    
    if([request isKindOfClass:[VPMutableURLRequest class]]) {
        VPMutableURLRequest *mutableRequest = (VPMutableURLRequest*)request;
        [[mutableRequest data] setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSURLRequest *request = [connection currentRequest];
    
    if([request isKindOfClass:[VPMutableURLRequest class]]) {
        VPMutableURLRequest *mutableRequest = (VPMutableURLRequest*)request;
        [[mutableRequest data] appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self didFailWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSURLRequest *request = [connection currentRequest];
    
    if([request isKindOfClass:[VPMutableURLRequest class]]) {
        VPMutableURLRequest *mutableRequest = (VPMutableURLRequest*)request;
        NSMutableData *data = mutableRequest.data;
                
        NSError *error = NULL;
        SMXMLDocument *xmlDocument = [[SMXMLDocument alloc] initWithData:data error:&error];

        if(error) {
            [self didFailWithError:error];
        }
        else {
            NSString *url = [[request URL] description];
            
            if([url isEqualToString:sDoFirstLoginUrl]) {
                [self didFinishFirstLogin:xmlDocument username:(NSString*)mutableRequest.tag];
            }
            else if([url isEqualToString:sDoSecondLoginUrl]) {
                [self didFinishSecondLogin:xmlDocument token:(VPUserToken*)mutableRequest.tag];
            }
            else if([url isEqualToString:sGetAccountListUrl]) {
                [self didFinishGetAccountList:xmlDocument token:(VPUserToken*)mutableRequest.tag];
            }
            else if([url isEqualToString:sGetAccountInfoUrl]) {
                NSArray *parameters = (NSArray*)mutableRequest.tag;
                [self didFinishGetInfoForAccount:(VPAccount*)[parameters lastObject]  token:(VPUserToken*)[parameters firstObject] withDocument:xmlDocument];
            }
        }
    }
}

- (void)didFinishFirstLogin:(SMXMLDocument*)document username:(NSString*)username
{
    SMXMLElement *resultElement = [[[document.root childNamed:@"Body"] childNamed:@"DoFirstLoginResponse"] childNamed:@"DoFirstLoginResult"];
    
    SMXMLElement *isSuccessElement = [resultElement childNamed:@"IsSuccess"];
    BOOL isSuccess = [[isSuccessElement value] boolValue];
    
    if(isSuccess) {
        SMXMLElement *tokenIdElement = [resultElement childNamed:@"TokenID"];
        VPUserToken *token = [[VPUserToken alloc] init];
        token.userName = username;
        token.tokenId = [tokenIdElement value];
        
        if([self.delegate respondsToSelector:@selector(bankService:didAuthenticateToken:)]) {
            [self.delegate bankService:self didAuthenticateToken:token];
        }
    }
    else {
        if([self.delegate respondsToSelector:@selector(bankService:didFailWithUserAuthentication:)]) {
            [self.delegate bankService:self didFailWithUserAuthentication:username];
        }
    }
}

- (void)didFinishSecondLogin:(SMXMLDocument*)document token:(VPUserToken*)token
{
    SMXMLElement *resultElement = [[[document.root childNamed:@"Body"] childNamed:@"DoSecondLoginResponse"] childNamed:@"DoSecondLoginResult"];
    
    SMXMLElement *isSuccessElement = [resultElement childNamed:@"IsSuccess"];
    BOOL isSuccess = [[isSuccessElement value] boolValue];
    
    if(isSuccess) {
        SMXMLElement *userNameElement = [resultElement childNamed:@"UserName"];
        SMXMLElement *sureNameElement = [resultElement childNamed:@"UserSurname"];
        
        [token setVerified:YES];
        token.firstName = [userNameElement value];
        token.sureName = [sureNameElement value];
        
        if([self.delegate respondsToSelector:@selector(bankService:didVerifyToken:)]) {
            [self.delegate bankService:self didVerifyToken:token];
        }
    }
    else {
        [token setVerified:NO];
        
        if([self.delegate respondsToSelector:@selector(bankService:didFailWithTokenVerification:)]) {
            [self.delegate bankService:self didFailWithTokenVerification:token];
        }
    }
}

- (void)didFinishGetAccountList:(SMXMLDocument*)document token:(VPUserToken*)token
{
    SMXMLElement *resultElement = [[[document.root childNamed:@"Body"] childNamed:@"GetAccountListResponse"] childNamed:@"GetAccountListResult"];
    
    SMXMLElement *isSuccessElement = [resultElement childNamed:@"IsSuccess"];
    BOOL isSuccess = [[isSuccessElement value] boolValue];
    
    if(isSuccess) {
        SMXMLElement *accountListElement = [resultElement childNamed:@"AccountList"];
        NSMutableArray *accounts = [[NSMutableArray alloc] init];
        
        for(SMXMLElement *accountElement in [accountListElement children]) {
            VPAccount *account = [[VPAccount alloc] init];
            account.number = [[accountElement childNamed:@"Number"] value];
            account.branchCode = [[accountElement childNamed:@"BranchCode"] value];
            account.branchName = [[accountElement childNamed:@"BranchName"] value];
            account.availableBalance = [[[accountElement childNamed:@"AvailableBalance"] value] doubleValue];
            account.balance = [[[accountElement childNamed:@"Balance"] value] doubleValue];
            account.currencyName = [[accountElement childNamed:@"CurrencyName"] value];
            account.type = [[[accountElement childNamed:@"AccountTypeBaseAccountType"] value] integerValue];
            [accounts addObject:account];
        }
        
        if([self.delegate respondsToSelector:@selector(bankService:fetchedAccounts:forToken:)]) {
            [self.delegate bankService:self fetchedAccounts:[accounts copy] forToken:token];
        }
    }
    else {
        NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSURLErrorKey: [document description],
                                                                                              NSLocalizedDescriptionKey: @"Cannot fetch the user accounts."}];
        [self didFailWithError:error];
    }
}

- (void)didFinishGetInfoForAccount:(VPAccount*)account token:(VPUserToken*)token withDocument:(SMXMLDocument*)document
{
    SMXMLElement *resultElement = [[[document.root childNamed:@"Body"] childNamed:@"GetAccountInfoResponse"] childNamed:@"GetAccountInfoResult"];
    
    SMXMLElement *isSuccessElement = [resultElement childNamed:@"IsSuccess"];
    BOOL isSuccess = [[isSuccessElement value] boolValue];
    
    if(isSuccess) {
        VPAccountInfo *accountInfo = [[VPAccountInfo alloc] init];
        accountInfo.accountNumber = [[resultElement childNamed:@"Number"] value];
        accountInfo.balance = [[[resultElement childNamed:@"MainBalance"] value] doubleValue];
        accountInfo.currencyName = account.currencyName;
        accountInfo.ibanNumber = [[resultElement childNamed:@"IBAN"] value];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        accountInfo.openedDate = [dateFormatter dateFromString:[[resultElement childNamed:@"OpenedDate"] value]];
        accountInfo.accountType = account.type;
        
        if([self.delegate respondsToSelector:@selector(bankService:fetchedInfo:forAccount:)]) {
            [self.delegate bankService:self fetchedInfo:accountInfo forAccount:account];
        }
    }
    else {
        NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:404 userInfo:@{NSURLErrorKey: [document description],
                                                                                              NSLocalizedDescriptionKey: @"Cannot fetch account information."}];
        [self didFailWithError:error];
    }
}

@end
