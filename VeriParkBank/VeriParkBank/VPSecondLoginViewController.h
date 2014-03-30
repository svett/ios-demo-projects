//
//  VPSecondLoginViewController.h
//  VeriParkBank
//
//  Created by Svetlin Ralchev on 11/3/13.
//  Copyright (c) 2013 Svett Ralchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPBankService.h"

@interface VPSecondLoginViewController : UIViewController<VPBankServiceDelegate>

@property (strong, nonatomic) IBOutlet UITextField *verificationTextField;

@end
