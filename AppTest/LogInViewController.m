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
    _txtPassword.secureTextEntry = YES;
   
    

}

-(IBAction)LogIn:(id)sender{
  //  **LOGIN**
    if (_txtEmail.text && _txtEmail.text.length >0 && _txtPassword.text && _txtPassword.text.length >0 ) {
        
        NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/login/"];
        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
        [rq setHTTPMethod:@"POST"];
        
        NSData *jsonData = [[NSString stringWithFormat: @"{\"email\":\"%@\",\"password\":\"%@\" }", _txtEmail.text, _txtPassword.text] dataUsingEncoding:NSUTF8StringEncoding];
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
             NSArray *result = [json objectForKey:@"sceResponseCode"];
             
             NSLog(@"codigo: %@", result);
         }];

    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campo requerido"
                                                        message:@"Hay uno o más campos requeridos que están vacíos."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    
    }

    
        NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/login/"];
        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
        [rq setHTTPMethod:@"POST"];
    
        NSData *jsonData = [[NSString stringWithFormat: @"{\"email\":\"%@\",\"password\":\"%@\" }", _txtEmail.text, _txtPassword.text] dataUsingEncoding:NSUTF8StringEncoding];
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
             NSArray *result = [json objectForKey:@"result"];
             
             NSLog(@"codigo: %@", result);
         }];


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
