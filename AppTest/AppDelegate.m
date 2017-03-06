//
//  AppDelegate.m
//  AppTest
//
//  Created by Rafael Perez on 8/29/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "AppDelegate.h"
#import "FDKeychain.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize loggedIn = _loggedIn;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [GIDSignIn sharedInstance].clientID = @"145983789010-9gplconbupem4sih9cr5b2tdqlgioqiq.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].delegate = self;
    

    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    _loggedIn = [FDKeychain itemForKey: @"loggedin"
                            forService: @"BIXI"
                                 error: nil];
    if ([_loggedIn isEqualToString:@"YES"]) {
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"OffersViewController"];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];

    }
    else{
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
        
    }


    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled || [[GIDSignIn sharedInstance] handleURL:url
                                                  sourceApplication:sourceApplication
                                                         annotation:annotation];
    
    return handled;
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    // ...
    [FDKeychain saveItem: @"YES"
                  forKey: @"loggedin"
              forService: @"BIXI"
                   error: nil];
    
    [FDKeychain saveItem: user.authentication.accessToken
                  forKey: @"usertoken"
              forService: @"BIXI"
                   error: nil];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"OffersViewController"];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary *)options {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}


//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary *)options {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
