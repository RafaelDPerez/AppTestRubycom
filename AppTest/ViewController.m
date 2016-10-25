//
//  ViewController.m
//  AppTest
//
//  Created by Rafael Perez on 8/29/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSString *string;;

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

- (void)onButtonPressed:(UIButton *)button {
    
    // "button" is the button which is pressed
    
    if([string length]<4) {
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
    if ([string length]==4) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password"
                                                        message:@"Esta es una prueba."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        string = @"";
        _passTxt.text = string;
        
        // If you're not using ARC, you will need to release the alert view.
        // [alert release];
    }

    
    // You can still get the tag
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
