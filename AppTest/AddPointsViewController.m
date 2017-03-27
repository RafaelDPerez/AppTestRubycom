//
//  AddPointsViewController.m
//  AppTest
//
//  Created by Rafael Perez on 3/26/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "AddPointsViewController.h"
#import "ViewController.h"

@interface AddPointsViewController ()<UITextFieldDelegate, UITextViewDelegate>

@end

@implementation AddPointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
    _txtDescription.text = @"Descripción";
    _txtDescription.textColor = [UIColor lightGrayColor];
    _txtDescription.clipsToBounds = YES;
    

    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"cancelar"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)handleBack:(id)sender {
    // pop to root view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dismissKeyboard {
    [_txtDescription resignFirstResponder];
    [_txtPoints resignFirstResponder];
  
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ConfirmPoints"]) {
        ViewController *KeyboardViewController = [segue destinationViewController];
        //     [cell getCurrentIndex];
        KeyboardViewController.points = _txtPoints.text;
        KeyboardViewController.pointsDescription = _txtDescription.text;
        KeyboardViewController.Message = @"Los puntos han sido agregados!";
        KeyboardViewController.Type = @"1";
        
    }
  
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Descripción"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    else{
        textView.textColor = [UIColor blackColor];
        
    }
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    // [textView scrollRangeToVisible:NSMakeRange(1, 1)];
    [textView setContentOffset:CGPointZero animated:YES];
    if([textView.text isEqualToString:@""])
    {
            textView.text = @"Descripción";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // allow backspace
    if (!string.length)
    {
        return YES;
    }
    
    // Prevent invalid character input, if keyboard is numberpad
    if (textField.keyboardType == UIKeyboardTypeNumberPad)
    {
        if ([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet].location != NSNotFound)
        {
            // BasicAlert(@"", @"This field accepts only numeric entries.");
            return NO;
        }
    }
    
    // verify max length has not been exceeded
    NSString *proposedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (proposedText.length > 6) // 4 was chosen for SSN verification
    {
        // suppress the max length message only when the user is typing
        // easy: pasted data has a length greater than 1; who copy/pastes one character?
        if (string.length > 1)
        {
            // BasicAlert(@"", @"This field accepts a maximum of 4 characters.");
        }
        
        return NO;
    }
    
    // only enable the OK/submit button if they have entered all numbers for the last four of their SSN (prevents early submissions/trips to authentication server)
    //self.answerButton.enabled = (proposedText.length == 4);
    
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
