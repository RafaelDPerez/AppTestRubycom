//
//  ForgotPasswordViewController.m
//  AppTest
//
//  Created by Rafael Perez on 1/29/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ACFloatingTextField.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtForgotPassword;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];

    // Do any additional setup after loading the view.
    [_txtForgotPassword setTextFieldPlaceholderText:@"email"];
    _txtForgotPassword.selectedLineColor = [UIColor whiteColor];
    _txtForgotPassword.placeHolderColor = [UIColor whiteColor];
    [_txtForgotPassword setTextColor:[UIColor whiteColor]];
    _txtForgotPassword.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtForgotPassword.lineColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
