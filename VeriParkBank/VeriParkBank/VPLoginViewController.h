//
//  VPLoginViewController.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPBankService.h"

@interface VPLoginViewController : UIViewController<VPBankServiceDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end
