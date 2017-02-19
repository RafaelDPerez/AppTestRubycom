//
//  LogInViewController.h
//  AppTest
//
//  Created by Rafael Perez on 1/29/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LogInViewController : UIViewController
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@end
