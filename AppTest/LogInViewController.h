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
@import GoogleSignIn;

@interface LogInViewController : UIViewController<GIDSignInUIDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property(weak, nonatomic) IBOutlet GIDSignInButton *signInButton;
@end
