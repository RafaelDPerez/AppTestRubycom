//
//  ViewController.m
//  AppTest
//
//  Created by Rafael Perez on 8/29/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "ViewController.h"
#import "FDKeyChain.h"

@interface ViewController ()

@end

@implementation ViewController
NSString *string;;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    _passTxt.text = @"";
    string = @"";
    // Do any additional setup after loading the view, typically from a nib.
    [_oneBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_twoBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_threeBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_fourBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_fiveBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_sixBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_sevenBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_eightBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_nineBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_tenBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    [_clearBtn addTarget:self action:@selector(onButtonPressed:)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"cancelar"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

}


- (void)handleBack:(id)sender {
    // pop to root view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)onButtonPressed:(UIButton *)button {
    
    // "button" is the button which is pressed
//    if (string.length==6) {
//        _passTxt.text = @"";
//        string = @"";
//    }
    if([string length]<6) {
        if (button.tag == 99) {
            if ([string length] > 0) {
                string = [string substringToIndex:[string length] - 1];
                _passTxt.text = string;
            }
        }
        else{
        string = [_passTxt.text stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)button.tag]];
        _passTxt.text = string;
        }
    }
    if ([string length]==6) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password"
//                                                        message:@"Esta es una prueba."
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        string = @"";
//        _passTxt.text = string;
        [self addPoints];
        // If you're not using ARC, you will need to release the alert view.
        // [alert release];
    }

    
    // You can still get the tag
    
}

-(IBAction)addPoints{
    if ([self.Type isEqualToString:@"1"]){
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
    //**REGISTER**
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/add_points/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    
    NSData *jsonData = [[NSString stringWithFormat:@"{\"pin\":\"%@\",\"points\":\"%@\",\"description\":\"%@\"}",_passTxt.text, self.points, self.pointsDescription] dataUsingEncoding:NSUTF8StringEncoding];
    [rq setHTTPBody:jsonData];
    
    [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:rq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSError* error;
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
         NSNumber *sceResponseCode = [json objectForKey:@"sceResponseCode"];
         NSString *sceResponseMsg = [json objectForKey:@"sceResponseMsg"];
         
         if ([sceResponseCode longLongValue]==0) {
             //[self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
            // [self.navigationController popToRootViewControllerAnimated:YES];
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BIXI"
                                                             message:self.Message
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
             [self.navigationController popToRootViewControllerAnimated:YES];
         }
         if ([sceResponseCode longLongValue]==1) {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:sceResponseMsg
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
         }
     }];
    }
    if ([self.Type isEqualToString:@"2"]) {
        NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
        //**REGISTER**
        NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/reclaim/"];
        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
        [rq setHTTPMethod:@"POST"];
        
        NSData *jsonData = [[NSString stringWithFormat:@"{\"pin\":\"%@\",\"product_id\":\"%@\"}",_passTxt.text, self.productID] dataUsingEncoding:NSUTF8StringEncoding];
        [rq setHTTPBody:jsonData];
        
        [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
        [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [NSURLConnection sendAsynchronousRequest:rq
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             NSError* error;
             NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&error];
             NSNumber *sceResponseCode = [json objectForKey:@"sceResponseCode"];
             NSString *sceResponseMsg = [json objectForKey:@"sceResponseMsg"];
             
             if ([sceResponseCode longLongValue]==0) {
                 //[self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
                 // [self.navigationController popToRootViewControllerAnimated:YES];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BIXI"
                                                                 message:self.Message
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 //[self.navigationController popToRootViewControllerAnimated:YES];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             if ([sceResponseCode longLongValue]==1) {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:sceResponseMsg
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
             }
         }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
