//
//  Register2ViewController.m
//  AppTest
//
//  Created by Rafael Perez on 1/18/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "Register2ViewController.h"
#import "ACFloatingTextField.h"
#import "Register1ViewController.h"


@interface Register2ViewController ()<UITextFieldDelegate>{
Register1ViewController *hola;
}

@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtPhone1;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtPhone2;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtAddress;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtEmail;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtPassword;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtConfirmPassword;


@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hola = [[Register1ViewController alloc]init];
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
    
    [_txtPhone1 setTextFieldPlaceholderText:@"telefono 1"];
    _txtPhone1.selectedLineColor = [UIColor whiteColor];
    _txtPhone1.placeHolderColor = [UIColor whiteColor];
    [_txtPhone1 setTextColor:[UIColor whiteColor]];
    _txtPhone1.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtPhone1.lineColor = [UIColor whiteColor];
    
    [_txtPhone2 setTextFieldPlaceholderText:@"telefono 2"];
    _txtPhone2.selectedLineColor = [UIColor whiteColor];
    _txtPhone2.placeHolderColor = [UIColor whiteColor];
    [_txtPhone2 setTextColor:[UIColor whiteColor]];
    _txtPhone2.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtPhone2.lineColor = [UIColor whiteColor];
    
    [_txtAddress setTextFieldPlaceholderText:@"dirección"];
    _txtAddress.selectedLineColor = [UIColor whiteColor];
    _txtAddress.placeHolderColor = [UIColor whiteColor];
    [_txtAddress setTextColor:[UIColor whiteColor]];
    _txtAddress.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtAddress.lineColor = [UIColor whiteColor];
    
    _txtPassword.secureTextEntry = YES;
    _txtConfirmPassword.secureTextEntry = YES;
    _txtPhone1.keyboardType = UIKeyboardTypePhonePad;
    _txtPhone2.keyboardType = UIKeyboardTypePhonePad;
    _txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)RegisterUser:(id)sender{
    
    if (_txtEmail.text && _txtEmail.text.length > 0 && _txtPhone1.text && _txtPhone1.text.length > 0 &&_txtPassword.text && _txtPassword.text.length > 0 && _txtConfirmPassword.text && _txtConfirmPassword.text.length > 0 && _txtAddress.text && _txtAddress.text.length > 0)
    {
        
        self.user.password = _txtPassword.text;
        self.user.passwordConfirm = _txtConfirmPassword.text;
        self.user.phone1 = _txtPhone1.text;
        self.user.phone2 = _txtPhone2.text;
        self.user.email = _txtEmail.text;
        self.user.address = _txtAddress.text;
        NSLog(@"%@ - %@ -%@ -%@ -%@ -%@ -%@",self.user.firstName, self.user.lastName, self.user.documentId, self.user.phone1, self.user.phone2, self.user.address, self.user.gender, self.user.email, self.user.birthDate,self.user.password, self.user.passwordConfirm);
        
        if ([self.user.password isEqualToString:self.user.passwordConfirm]) {
            //**REGISTER**
            NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/user/"];
            NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
            [rq setHTTPMethod:@"PUT"];
            
            NSData *jsonData = [[NSString stringWithFormat:@"{\"first_name\":\"%@\",\"last_name\":\"%@\",\"document_id\":\"%@\",\"phone1\":\"%@\",\"phone2\":\"%@\",\"address\":\"%@\",\"gender\":\"%@\",\"email\":\"%@\",\"email_confirm\":\"%@\",\"birth_date\":\"%@\",\"password\":\"%@\",\"password_confirm\":\"%@\" }", self.user.firstName, self.user.lastName, self.user.documentId, self.user.phone1, self.user.phone2, self.user.address, self.user.gender, self.user.email,self.user.email, self.user.birthDate,self.user.password, self.user.passwordConfirm] dataUsingEncoding:NSUTF8StringEncoding];
            [rq setHTTPBody:jsonData];
            
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
                 NSString *sceResponseMsg = [json objectForKey:@"sceResponseMsg"];
                 
                 NSLog(@"codigo: %@", sceResponseMsg);
                 if ([sceResponseMsg isEqualToString:@"OK"]) {
                      [self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
                 }
                
             }];
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password"
                                                            message:@"Por favor confirmar password."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
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
