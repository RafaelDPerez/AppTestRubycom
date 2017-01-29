//
//  LogInViewController.m
//  AppTest
//
//  Created by Rafael Perez on 1/29/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "LogInViewController.h"
#import "ACFloatingTextField.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtForgotPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtRegister;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [_txtEmail setTextFieldPlaceholderText:@"email"];
    _txtEmail.selectedLineColor = [UIColor whiteColor];
    _txtEmail.placeHolderColor = [UIColor whiteColor];
    [_txtEmail setTextColor:[UIColor whiteColor]];
    _txtEmail.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtEmail.lineColor = [UIColor whiteColor];
    
    [_txtPassword setTextFieldPlaceholderText:@"contraseña"];
    _txtPassword.selectedLineColor = [UIColor whiteColor];
    _txtPassword.placeHolderColor = [UIColor whiteColor];
    [_txtPassword setTextColor:[UIColor whiteColor]];
    _txtPassword.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtPassword.lineColor = [UIColor whiteColor];
    
    [_txtRegister setTextFieldPlaceholderText:@"¿eres nuevo? regístrate"];
    _txtRegister.selectedLineColor = [UIColor whiteColor];
    _txtRegister.placeHolderColor = [UIColor whiteColor];
    [_txtRegister setTextColor:[UIColor whiteColor]];
    _txtRegister.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtRegister.lineColor = [UIColor whiteColor];
    
    [_txtForgotPassword setTextFieldPlaceholderText:@"¿olvidó su contraseña?"];
    _txtForgotPassword.selectedLineColor = [UIColor whiteColor];
    _txtForgotPassword.placeHolderColor = [UIColor whiteColor];
    [_txtForgotPassword setTextColor:[UIColor whiteColor]];
    _txtForgotPassword.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtForgotPassword.lineColor = [UIColor whiteColor];
    

}

#pragma mark  UITextfield Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_txtEmail resignFirstResponder];
    [_txtPassword resignFirstResponder];

    return YES;
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
