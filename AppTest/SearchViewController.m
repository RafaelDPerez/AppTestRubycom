//
//  SearchViewController.m
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "SearchViewController.h"
#import "ACFloatingTextField.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtCommerceId;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtLocation;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtOrderBy;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    [_txtCommerceId setTextFieldPlaceholderText:@"tipo de establecimiento"];
    _txtCommerceId.selectedLineColor = [UIColor whiteColor];
    _txtCommerceId.placeHolderColor = [UIColor whiteColor];
    [_txtCommerceId setTextColor:[UIColor whiteColor]];
    _txtCommerceId.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtCommerceId.lineColor = [UIColor whiteColor];
    
    [_txtLocation setTextFieldPlaceholderText:@"ubicación"];
    _txtLocation.selectedLineColor = [UIColor whiteColor];
    _txtLocation.placeHolderColor = [UIColor whiteColor];
    [_txtLocation setTextColor:[UIColor whiteColor]];
    _txtLocation.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtLocation.lineColor = [UIColor whiteColor];
    
    [_txtOrderBy setTextFieldPlaceholderText:@"ordenar por:"];
    _txtOrderBy.selectedLineColor = [UIColor whiteColor];
    _txtOrderBy.placeHolderColor = [UIColor whiteColor];
    [_txtOrderBy setTextColor:[UIColor whiteColor]];
    _txtOrderBy.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtOrderBy.lineColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
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
