//
//  SearchViewController.m
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "SearchViewController.h"
#import "ACFloatingTextField.h"
#import "FDKeyChain.h"
#import "FilteredOffersTableViewController.h"
#import "FilteredOffersNavigationViewController.h"


@interface SearchViewController ()<UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtCommerceId;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtOrderBy;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtOffer;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIPickerView *orderBypickerView;
@end
NSMutableArray *commerceTypeArray;
NSMutableArray *orderByList;

@implementation SearchViewController
@synthesize commerceTypeSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    commerceTypeSelected = [[CommerceType alloc]init];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoBixi2"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    commerceTypeArray = [[NSMutableArray alloc]init];
    orderByList = [[NSMutableArray alloc]init];
    [_txtCommerceId setTextFieldPlaceholderText:@"tipo de establecimiento"];
    _txtCommerceId.selectedLineColor = [UIColor whiteColor];
    _txtCommerceId.placeHolderColor = [UIColor whiteColor];
    [_txtCommerceId setTextColor:[UIColor whiteColor]];
    _txtCommerceId.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtCommerceId.lineColor = [UIColor whiteColor];
    

    
    [_txtOffer setTextFieldPlaceholderText:@"oferta"];
    _txtOffer.selectedLineColor = [UIColor whiteColor];
    _txtOffer.placeHolderColor = [UIColor whiteColor];
    [_txtOffer setTextColor:[UIColor whiteColor]];
    _txtOffer.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtOffer.lineColor = [UIColor whiteColor];
    
    [_txtOrderBy setTextFieldPlaceholderText:@"ordenar por:"];
    _txtOrderBy.selectedLineColor = [UIColor whiteColor];
    _txtOrderBy.placeHolderColor = [UIColor whiteColor];
    [_txtOrderBy setTextColor:[UIColor whiteColor]];
    _txtOrderBy.selectedPlaceHolderColor = [UIColor whiteColor];
    _txtOrderBy.lineColor = [UIColor whiteColor];
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;     //#2
    self.pickerView.dataSource = self;   //#2
    _txtCommerceId.inputView = self.pickerView;
    
    _sldBIXIPoints.maximumValue = 300.0f;
    _sldBIXIPoints.minimumValue = 10.0f;
    
    self.orderBypickerView = [[UIPickerView alloc] init];
    self.orderBypickerView.delegate = self;     //#2
    self.orderBypickerView.dataSource = self;   //#2
    _txtOrderBy.inputView = self.orderBypickerView;
    orderByList = @[@"NAME-ASC", @"NAME-DESC", @"DESCRIPTION-ASC",
				@"DESCRIPTION-DESC", @"TAG-ASC", @"AG-DESC", @"POINT-ASC", @"POINT-DESC"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/type_commerce_list/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"GET"];
    //NSData *jsonData = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    //[rq setHTTPBody:jsonData];
    [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
    
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //        [rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:rq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSError* error;
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
         NSString *message = [json objectForKey:@"sceResponseMsg"];
         NSArray *result = [json objectForKey:@"result"];
         if ([message isEqualToString:@"OK"]) {
             NSArray *result = [json objectForKey:@"result"];
             for (int i = 0; i<= result.count - 1; i++) {
                 //now let's dig out each and every json object
                 CommerceType *commerceType = [[CommerceType alloc]init];
                 NSDictionary *dict = [result objectAtIndex:i];
                 commerceType.CommerceType = [dict objectForKey:@"type_commerce"];
                 commerceType.CommerceTypeID = [dict objectForKey:@"type_commerce_id"];
                 [commerceTypeArray addObject:commerceType];
             }
         }
         NSLog(@"codigo: %@", result);
     }];
    
}

#pragma mark - UIPickerViewDataSource

// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.pickerView) {
        return 1;
    }

    if (pickerView == self.orderBypickerView) {
        return 1;
    }

    
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return [commerceTypeArray count];
    }
    if (pickerView == self.orderBypickerView) {
        return [orderByList count];
    }
    
    return 0;
}

-(IBAction)searchOffers:(id)sender{
    NSLog(@"sider value:%d y %@ y %@ y %@",(int)(_sldBIXIPoints.value),_txtOrderBy.text,commerceTypeSelected.CommerceTypeID, _txtSearch.text);
    

    
    [self performSegueWithIdentifier:@"callFilteredOffers" sender:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"callFilteredOffers"]) {
        FilteredOffersNavigationViewController *navController = [segue destinationViewController];
        
        FilteredOffersTableViewController *filteredviewController = navController.topViewController;
        //     [cell getCurrentIndex];
        filteredviewController.location = _txtSearch.text;
        filteredviewController.orderBy = _txtOrderBy.text;
        if (commerceTypeSelected.CommerceTypeID == nil) {
            filteredviewController.commerceType = @"";
        }
        else {
        filteredviewController.commerceType = commerceTypeSelected.CommerceTypeID;
        }
        filteredviewController.BIXIPoints = [NSString stringWithFormat:@"%d",(int)(_sldBIXIPoints.value)];
      
    }

    
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        CommerceType *selected = [[CommerceType alloc]init];
        selected = [commerceTypeArray objectAtIndex:row];
        return selected.CommerceType;
    }
    if (pickerView == self.orderBypickerView) {
        return orderByList[row];
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        CommerceType *selected = [[CommerceType alloc]init];
        selected = [commerceTypeArray objectAtIndex:row];
        self.txtCommerceId.text = selected.CommerceType;
        commerceTypeSelected = selected;
    }
    if (pickerView == self.orderBypickerView) {
        self.txtOrderBy.text = orderByList[row];
    }
}

-(void)dismissKeyboard {
    [_txtCommerceId resignFirstResponder];
    [_txtOrderBy resignFirstResponder];
    
    
    
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
