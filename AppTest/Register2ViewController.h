//
//  Register2ViewController.h
//  AppTest
//
//  Created by Rafael Perez on 1/18/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface Register2ViewController : UIViewController
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;

//-(IBAction)RegisterUser:(id)sender;
@end
