//
//  ChangePasswordViewController.m
//  AppTest
//
//  Created by Rafael Perez on 3/13/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ACFloatingTextField.h"
#import "FDKeyChain.h"


@interface ChangePasswordViewController ()
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtCurrentPassword;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtNewPassword;
@property (strong, nonatomic) IBOutlet ACFloatingTextField *txtRepNewPassword;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    // change the back button to cancel and add an event handler
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"cancelar"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    [_txtCurrentPassword setTextFieldPlaceholderText:@"contraseña actual"];
    _txtCurrentPassword.selectedLineColor = [UIColor whiteColor];
    _txtCurrentPassword.placeHolderColor = [UIColor whiteColor];
    [_txtCurrentPassword setTextColor:[UIColor whiteColor]];
    _txtCurrentPassword.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtCurrentPassword.lineColor = [UIColor whiteColor];
    
    [_txtNewPassword setTextFieldPlaceholderText:@"contraseña nueva"];
    _txtNewPassword.selectedLineColor = [UIColor whiteColor];
    _txtNewPassword.placeHolderColor = [UIColor whiteColor];
    [_txtNewPassword setTextColor:[UIColor whiteColor]];
    _txtNewPassword.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtNewPassword.lineColor = [UIColor whiteColor];
    
    [_txtRepNewPassword setTextFieldPlaceholderText:@"confirmar nueva contraseña"];
    _txtRepNewPassword.selectedLineColor = [UIColor whiteColor];
    _txtRepNewPassword.placeHolderColor = [UIColor whiteColor];
    [_txtRepNewPassword setTextColor:[UIColor whiteColor]];
    _txtRepNewPassword.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtRepNewPassword.lineColor = [UIColor whiteColor];
    
    _txtCurrentPassword.secureTextEntry = YES;
    _txtNewPassword.secureTextEntry = YES;
    _txtRepNewPassword.secureTextEntry = YES;

}

- (void)handleBack:(id)sender {
    // pop to root view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)setNewPassword:(id)sender{
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
    //**REGISTER**
        NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/user/"];
        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
        [rq setHTTPMethod:@"POST"];
    
    NSData *jsonData = [[NSString stringWithFormat:@"{\"first_name\":\"%@\",\"last_name\":\"%@\",\"document_id\":\"%@\",\"phone1\":\"%@\",\"phone2\":\"%@\",\"address\":\"%@\",\"gender\":\"%@\",\"email\":\"%@\",\"birth_date\":\"%@\",\"image\":\"%@\",\"old_password\":\"%@\",\"new_password\":\"%@\",\"new_password_confirm\":\"%@\"}", self.user.firstName, self.user.lastName, self.user.documentId, self.user.phone1, self.user.phone2, self.user.address, self.user.gender, self.user.email,self.user.birthDate, self.user.image,_txtCurrentPassword.text, _txtNewPassword.text,_txtRepNewPassword.text] dataUsingEncoding:NSUTF8StringEncoding];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
