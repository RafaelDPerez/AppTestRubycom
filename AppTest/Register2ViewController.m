//
//  Register2ViewController.m
//  AppTest
//
//  Created by Rafael Perez on 1/18/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "Register2ViewController.h"


@interface Register2ViewController ()


@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)RegisterUser:(id)sender{
    self.user.password = _txtPassword.text;
    self.user.passwordConfirm = _txtConfirmPassword.text;
    self.user.phone1 = _txtMobile.text;
    self.user.email = _txtEmail.text;
    NSLog(@"%@ - %@ -%@ -%@ -%@ -%@ -%@",self.user.password, self.user.passwordConfirm, self.user.gender, self.user.email, self.user.firstName, self.user.age, self.user.phone1);

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
