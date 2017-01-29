//
//  Register2ViewController.m
//  AppTest
//
//  Created by Rafael Perez on 1/18/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "Register2ViewController.h"
#import "ACFloatingTextField.h"


@interface Register2ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtMobile;
@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    // Do any additional setup after loading the view.
    [_txtEmail setTextFieldPlaceholderText:@"correo"];
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
    
    [_txtConfirmPassword setTextFieldPlaceholderText:@"confirmar contraseña"];
    _txtConfirmPassword.selectedLineColor = [UIColor whiteColor];
    _txtConfirmPassword.placeHolderColor = [UIColor whiteColor];
    [_txtConfirmPassword setTextColor:[UIColor whiteColor]];
    _txtConfirmPassword.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtConfirmPassword.lineColor = [UIColor whiteColor];
    
    [_txtMobile setTextFieldPlaceholderText:@"movil"];
    _txtMobile.selectedLineColor = [UIColor whiteColor];
    _txtMobile.placeHolderColor = [UIColor whiteColor];
    [_txtMobile setTextColor:[UIColor whiteColor]];
    _txtMobile.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtMobile.lineColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)RegisterUser:(id)sender{
    
    if (_txtEmail.text && _txtEmail.text.length > 0 && _txtMobile.text && _txtMobile.text.length > 0 &&_txtPassword.text && _txtPassword.text.length > 0 && _txtConfirmPassword.text && _txtConfirmPassword.text.length > 0 )
    {
        
        self.user.password = _txtPassword.text;
        self.user.passwordConfirm = _txtConfirmPassword.text;
        self.user.phone1 = _txtMobile.text;
        self.user.email = _txtEmail.text;
        NSLog(@"%@ - %@ -%@ -%@ -%@ -%@ -%@",self.user.password, self.user.passwordConfirm, self.user.gender, self.user.email, self.user.firstName, self.user.age, self.user.phone1);
        [self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campo requerido"
                                                        message:@"Hay uno o más campos requeridos que están vacíos."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    


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
