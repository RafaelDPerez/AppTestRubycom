//
//  AppDelegate.h
//  AppTest
//
//  Created by Rafael Perez on 8/29/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleSignIn;


@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) NSString *loggedIn;

@end

