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
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtFirstName;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtLastName;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtDocumentID;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtDateOfBirth;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtSex;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong,nonatomic) NSArray *pickerNames;



@end

@implementation Register1ViewController
BOOL Registercompletion;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    Registercompletion = NO;
    [_txtFirstName setTextFieldPlaceholderText:@"primer nombre"];
    _txtFirstName.selectedLineColor = [UIColor whiteColor];
    _txtFirstName.placeHolderColor = [UIColor whiteColor];
    [_txtFirstName setTextColor:[UIColor whiteColor]];
    _txtFirstName.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtFirstName.lineColor = [UIColor whiteColor];
    
    [_txtLastName setTextFieldPlaceholderText:@"segundo nombre"];
    _txtLastName.selectedLineColor = [UIColor whiteColor];
    _txtLastName.placeHolderColor = [UIColor whiteColor];
    [_txtLastName setTextColor:[UIColor whiteColor]];
    _txtLastName.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtLastName.lineColor = [UIColor whiteColor];
    
    [_txtDocumentID setTextFieldPlaceholderText:@"documento de identidad"];
    _txtDocumentID.selectedLineColor = [UIColor whiteColor];
    _txtDocumentID.placeHolderColor = [UIColor whiteColor];
    [_txtDocumentID setTextColor:[UIColor whiteColor]];
    _txtDocumentID.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtDocumentID.lineColor = [UIColor whiteColor];
    
    [_txtDateOfBirth setTextFieldPlaceholderText:@"fecha de nacimiento"];
    _txtDateOfBirth.selectedLineColor = [UIColor whiteColor];
    _txtDateOfBirth.placeHolderColor = [UIColor whiteColor];
    [_txtDateOfBirth setTextColor:[UIColor whiteColor]];
    _txtDateOfBirth.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtDateOfBirth.lineColor = [UIColor whiteColor];
    
    [_txtSex setTextFieldPlaceholderText:@"sexo"];
    _txtSex.selectedLineColor = [UIColor whiteColor];
    _txtSex.placeHolderColor = [UIColor whiteColor];
    [_txtSex setTextColor:[UIColor whiteColor]];
    _txtSex.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtSex.lineColor = [UIColor whiteColor];
    _txtSex.allowsEditingTextAttributes = NO;
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;     //#2
    self.pickerView.dataSource = self;   //#2
    self.pickerNames = @[ @"M", @"F"];
    _txtSex.inputView = self.pickerView;
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
//    NSString *maxDateString = @"01/01/1996";
//    // the date formatter used to convert string to date
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    // the specific format to use
//    dateFormatter.dateFormat = @"dd/MM/yyyy";
//    // converting string to date
//    NSDate *theMaximumDate = [dateFormatter dateFromString: maxDateString];
    
    // repeat the same logic for theMinimumDate if needed
    
    // here you can assign the max and min dates to your datePicker
    //[datePicker setMaximumDate:theMaximumDate]; //the min age restriction
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
   
    [self.txtDateOfBirth setInputView:datePicker];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    

}

#pragma mark - UIPickerViewDataSource

// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.pickerView) {
        return 1;
    }
    
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return [self.pickerNames count];
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return self.pickerNames[row];
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        self.txtSex.text = self.pickerNames[row];
    }
}

-(void)dismissKeyboard {
    [_txtFirstName resignFirstResponder];
    [_txtLastName resignFirstResponder];
    [_txtDateOfBirth resignFirstResponder];
    [_txtSex resignFirstResponder];
    [_txtDocumentID resignFirstResponder];

    
}

#pragma mark  UITextfield Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}



-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.txtDateOfBirth.inputView;
    //self.txtDateOfBirth.text = [NSString stringWithFormat:@"%@",picker.date];
    self.txtDateOfBirth.text = [self formatDate:picker.date];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];

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
    
    
//   // **GET PRODUCTS**
//        NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/search_products/"];
//        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
//        [rq setHTTPMethod:@"POST"];
//        NSData *jsonData = [@"" dataUsingEncoding:NSUTF8StringEncoding];
//        [rq setHTTPBody:jsonData];
//        [rq setValue:@"276wed2ItrjPLlp1Z9uKAxbCMcgy8NU7SEf" forHTTPHeaderField:@"X-Request-Id"];
//    
//        [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
////        [rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
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
if (_txtFirstName.text && _txtFirstName.text.length > 0 && _txtLastName.text && _txtLastName.text.length > 0 &&_txtDocumentID.text && _txtDocumentID.text.length > 0 && _txtSex.text && _txtSex.text.length > 0 && _txtDateOfBirth.text && _txtDateOfBirth.text.length > 0  )
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
        NSString *hola = _txtDateOfBirth.text;
        Register2ViewController *register2ViewController = [segue destinationViewController];
        register2ViewController.user = [[User alloc]init];
        register2ViewController.user.firstName = _txtFirstName.text;
        register2ViewController.user.lastName = _txtLastName.text;
        register2ViewController.user.gender = _txtSex.text;
        register2ViewController.user.documentId = _txtDocumentID.text;
        register2ViewController.user.birthDate = hola;
        
        NSLog(_txtDateOfBirth.text);
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
