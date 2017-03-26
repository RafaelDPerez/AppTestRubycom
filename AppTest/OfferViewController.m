//
//  OfferViewController.m
//  AppTest
//
//  Created by Rafael Perez on 9/19/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "OfferViewController.h"
#import "Offer.h"


@interface OfferViewController ()

@end

@implementation OfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Offer *offer = [[Offer alloc]init];
//    offer = self.Offer;
  self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"atrás"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    _imgOffer.image = [UIImage imageNamed:self.hola];
    _lblPoints.text = [NSString stringWithFormat:@"%@B",self.offer.OfferPoints ];
    _lblOfferName.text = self.offer.OfferName;
    _lblOfferDescription.text = self.offer.OfferDescription;
}

- (void)handleBack:(id)sender {
    // pop to root view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
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
