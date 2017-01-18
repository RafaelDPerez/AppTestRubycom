//
//  Register1ViewController.m
//  AppTest
//
//  Created by Rafael Perez on 1/17/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "Register1ViewController.h"

@interface Register1ViewController ()
@end

@implementation Register1ViewController
BOOL Registercompletion;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    Registercompletion = NO;
    
    // Do any additional setup after loading the view.
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
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/user/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"PUT"];
    
    NSData *jsonData = [@"{\"first_name\":\"Rafael\",\"last_name\":\"Perez\",\"document_id\":\"22400530790\",\"phone1\":\"8293435685\",\"phone2\":\"8095312396\",\"address\":\"Calle 9 no 9 Res Don Luis apto 101\",\"gender\":\"M\",\"email\":\"rafaeldavidp91@gmail.com\",\"birth_date\":\"03/02/1991\",\"image\":\"http://cdn.iconsmash.com/Content/icons/Iconshock-tiny-batman-vista-icons/iconpreviews/256/Logo.png\",\"password\":\"1234qwer\",\"password_confirm\":\"1234qwer\" }" dataUsingEncoding:NSUTF8StringEncoding];
    [rq setHTTPBody:jsonData];
    
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:rq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSLog(@"%@", data);
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
