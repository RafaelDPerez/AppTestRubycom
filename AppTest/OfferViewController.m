//
//  OfferViewController.m
//  AppTest
//
//  Created by Rafael Perez on 9/19/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "OfferViewController.h"

@interface OfferViewController ()

@end

@implementation OfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    _imgOffer.image = [UIImage imageNamed:self.hola];
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
