//
//  Register1ViewController.m
//  AppTest
//
//  Created by Rafael Perez on 1/17/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "Register1ViewController.h"
#import "Register2ViewController.h"
#import "ACFloatingTextField.h"

@interface Register1ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtNombre;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEdad;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtSexo;

@end

@implementation Register1ViewController
BOOL Registercompletion;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    Registercompletion = NO;
    [_txtNombre setTextFieldPlaceholderText:@"nombre"];
    _txtNombre.selectedLineColor = [UIColor whiteColor];
    _txtNombre.placeHolderColor = [UIColor whiteColor];
    [_txtNombre setTextColor:[UIColor whiteColor]];
    _txtNombre.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtNombre.lineColor = [UIColor whiteColor];
    
    [_txtEdad setTextFieldPlaceholderText:@"edad"];
    _txtEdad.selectedLineColor = [UIColor whiteColor];
    _txtEdad.placeHolderColor = [UIColor whiteColor];
    [_txtEdad setTextColor:[UIColor whiteColor]];
    _txtEdad.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtEdad.lineColor = [UIColor whiteColor];
    
    [_txtSexo setTextFieldPlaceholderText:@"sexo"];
    _txtSexo.selectedLineColor = [UIColor whiteColor];
    _txtSexo.placeHolderColor = [UIColor whiteColor];
    [_txtSexo setTextColor:[UIColor whiteColor]];
    _txtSexo.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtSexo.lineColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

#pragma mark  UITextfield Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_txtNombre resignFirstResponder];
    [_txtEdad resignFirstResponder];
    [_txtSexo resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)ShowComponent:(UIButton *)sender {
//    if ((_txtNombre.text && _txtNombre.text.length > 0) && (_txtEdad.text && _txtEdad.text.length > 0) &&(_txtSexo.text && _txtSexo.text.length > 0 && !Registercompletion)) {
//        _txtEmail.hidden=NO;
//        _txtPassword.hidden=NO;
//        _txtPasswordConfirm.hidden=NO;
//        _txtMovil.hidden=NO;
//        Registercompletion = YES;
//    }
//    if(Registercompletion && (_txtPassword.text && _txtPassword.text.length > 0) && (_txtPasswordConfirm.text && _txtPasswordConfirm.text.length > 0) && (_txtMovil.text && _txtMovil.text.length > 0) &&(_txtEmail.text && _txtEmail.text.length)){
//        NSLog(@"funciona!");
//    
//    }
    
    //**REGISTER**
//    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/user/"];
//    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
//    [rq setHTTPMethod:@"PUT"];
//    
//    NSData *jsonData = [@"{\"first_name\":\"Rafael\",\"last_name\":\"Perez\",\"document_id\":\"22400530790\",\"phone1\":\"8293435685\",\"phone2\":\"8095312396\",\"address\":\"Calle 9 no 9 Res Don Luis apto 101\",\"gender\":\"M\",\"email\":\"rafaeldavidp91@gmail.com\",\"email_confirm\":\"rafaeldavidp91@gmail.com\",\"birth_date\":\"03/02/1991\",\"password\":\"1234qwer\",\"password_confirm\":\"1234qwer\" }" dataUsingEncoding:NSUTF8StringEncoding];
//    [rq setHTTPBody:jsonData];
//    
//    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
//    [NSURLConnection sendAsynchronousRequest:rq
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response,
//                                               NSData *data, NSError *connectionError)
//     {
//         NSError* error;
//         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                              options:kNilOptions
//                                                                error:&error];
//         NSArray *sceResponseCode = [json objectForKey:@"sceResponseCode"];
//         
//         NSLog(@"codigo: %@", sceResponseCode);
//     }];
//    
    
    
//**LOGIN**
//    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/login/"];
//    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
//    [rq setHTTPMethod:@"POST"];
//    
//    NSData *jsonData = [@"{\"email\":\"rafaeldavidp91@gmail.com\",\"password\":\"1234qwer\" }" dataUsingEncoding:NSUTF8StringEncoding];
//    [rq setHTTPBody:jsonData];
//    
//    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
//    [NSURLConnection sendAsynchronousRequest:rq
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response,
//                                               NSData *data, NSError *connectionError)
//     {
//         NSError* error;
//         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                              options:kNilOptions
//                                                                error:&error];
//         NSArray *result = [json objectForKey:@"result"];
//         
//         NSLog(@"codigo: %@", result);
//     }];
    

    
    //        NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/user/"];
//        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
//        [rq setHTTPMethod:@"GET"];
//    
////        NSData *jsonData = [@"{\"email\":\"rafaeldavidp91@gmail.com\",\"password\":\"1234qwer\" }" dataUsingEncoding:NSUTF8StringEncoding];
////        [rq setHTTPBody:jsonData];
//    
//        [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [rq setValue:@"276wed2ItrjPLlp1Z9uKAxbCMcgy8NU7SEf" forHTTPHeaderField:@"X-Request-Id"];
//        //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
//        [NSURLConnection sendAsynchronousRequest:rq
//                                           queue:[NSOperationQueue mainQueue]
//                               completionHandler:^(NSURLResponse *response,
//                                                   NSData *data, NSError *connectionError)
//         {
//             NSError* error;
//             NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
//                                                                  options:kNilOptions
//                                                                    error:&error];
//             NSArray *result = [json objectForKey:@"result"];
//             
//             NSLog(@"codigo: %@", result);
//         }];

    
    }

//token = 276wed2ItrjPLlp1Z9uKAxbCMcgy8NU7SEf

-(IBAction)nextRegister:(id)sender{
if (_txtNombre.text && _txtNombre.text.length > 0 && _txtSexo.text && _txtSexo.text.length > 0 &&_txtEdad.text && _txtEdad.text.length > 0  )
{
    
     [self performSegueWithIdentifier:@"NextRegister" sender:self];
}
else{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Campo requerido"
                                                    message:@"Hay uno o más campos requeridos que están vacíos."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    if ([segue.identifier isEqualToString:@"NextRegister"]) {

//        NSIndexPath *indexPaths = [self.tableView indexPathForSelectedRow];
        Register2ViewController *register2ViewController = [segue destinationViewController];
        register2ViewController.user = [[User alloc]init];
        register2ViewController.user.firstName = _txtNombre.text;
        register2ViewController.user.age = _txtEdad.text;
        register2ViewController.user.gender = _txtSexo.text;
        
        NSLog(_txtNombre.text);
//        _selectedStation = [stationsArray objectAtIndex:indexPaths.row];
//        stationViewController.Station = _selectedStation;
//        [self.tableView deselectRowAtIndexPath:indexPaths animated:NO];
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
