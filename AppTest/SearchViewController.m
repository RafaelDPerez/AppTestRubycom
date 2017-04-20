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
#import "VKSideMenu.h"
#import "FilteredOffersTableViewController.h"
#import "FilteredOffersNavigationViewController.h"


@interface SearchViewController ()<UIPickerViewDelegate,VKSideMenuDelegate, VKSideMenuDataSource, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtCommerceId;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtOrderBy;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtOffer;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIPickerView *orderBypickerView;
@property (strong, nonatomic) UIPickerView *offerpickerView;
@property (nonatomic, strong) VKSideMenu *menuLeft;
@end
NSMutableArray *commerceTypeArray;
NSMutableArray *orderByList;
NSMutableArray *offerList;

@implementation SearchViewController
@synthesize commerceTypeSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuLeft = [[VKSideMenu alloc] initWithSize:280 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.navigationController.view];
    self.menuLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    commerceTypeSelected = [[CommerceType alloc]init];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoBixi2"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    commerceTypeArray = [[NSMutableArray alloc]init];
    orderByList = [[NSMutableArray alloc]init];
    offerList = [[NSMutableArray alloc]init];
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
    
    
    self.offerpickerView = [[UIPickerView alloc] init];
    self.offerpickerView.delegate = self;     //#2
    self.offerpickerView.dataSource = self;   //#2
    _txtOffer.inputView = self.offerpickerView;
    offerList = @[@"SI", @"NO", @"ULTIMO MINUTO"];
    
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

-(IBAction)Salir:(id)sender{
    [self performSegueWithIdentifier:@"callHomeSearch" sender:self];
}

#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return (sideMenu == self.menuLeft) ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 6;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    if (sideMenu == self.menuLeft) // All LEFT and TOP menu items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Inicio";
                item.icon  = [UIImage imageNamed:@"Home-50"];
                break;
                
            case 1:
                item.title = @"Mi Perfil";
                item.icon  = [UIImage imageNamed:@"ic_option_1"];
                break;
                
            case 2:
                item.title = @"Ofertas que me gustan";
                item.icon  = [UIImage imageNamed:@"Like-50"];
                break;
                
            case 3:
                item.title = @"Ofertas cerca de mí";
                item.icon  = [UIImage imageNamed:@"Near Me-50"];
                break;
                
            case 4:
                item.title = @"Salir";
                item.icon  = [UIImage imageNamed:@"Exit-50"];
                break;
                
            case 5:
                item.title = @"Transacciones";
                item.icon  = [UIImage imageNamed:@"Transaction List-50"];
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 0) // RIGHT menu first section items
    {
        item.title = @"Login";
    }
    else // RIGHT menu second section items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Like";
                break;
                
            case 1:
                item.title = @"Share";
                break;
            default:
                break;
        }
    }
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        [self performSegueWithIdentifier:@"callHomeSearch" sender:self];
    }
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"callProfile" sender:self];
    }
    if (indexPath.row ==2) {
        [self performSegueWithIdentifier:@"callFavorites" sender:self];
        
        //        [self dismissViewControllerAnimated:YES completion:nil];
        //        [self removeFromParentViewController];
        //        [self.view removeFromSuperview];
    }
    if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"callMap" sender:self];
    }
    
    if (indexPath.row ==4) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Salir"
                              message: @"Está seguro que desea salir de BIXI?"
                              delegate: self
                              cancelButtonTitle:@"NO"
                              otherButtonTitles:@"SI",nil];
        [alert show];
        
    }
    if (indexPath.row == 5) {
        [self performSegueWithIdentifier:@"callTransactions" sender:self];
    }
    NSLog(@"SideMenu didSelectRow: %@", indexPath);
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self logOut:self];
    }
    else {
        
    }
}

-(IBAction)logOut:(id)sender{
//    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
//    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    [loginManager logOut];
//    
//    [FBSDKAccessToken setCurrentAccessToken:nil];
//    [self performSegueWithIdentifier:@"backLogIn" sender:self];
//    [[GIDSignIn sharedInstance] signOut];
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did show", menu);
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did hide", menu);
}

-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return nil;
    
    switch (section)
    {
        case 0:
            return @"Profile";
            break;
            
        case 1:
            return @"Actions";
            break;
            
        default:
            return nil;
            break;
    }
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

    if (pickerView == self.offerpickerView) {
        return 1;
    }
    
    return 0;
}

-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
}


// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerView) {
        return [commerceTypeArray count];
    }
    if (pickerView == self.orderBypickerView) {
        return [orderByList count];
    }
    if (pickerView == self.offerpickerView) {
        return [offerList count];
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
    
    if (pickerView == self.offerpickerView) {
        return offerList[row];
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
    if (pickerView == self.offerpickerView) {
        self.txtOffer.text = offerList[row];
    }

}

-(void)dismissKeyboard {
    [_txtCommerceId resignFirstResponder];
    [_txtOrderBy resignFirstResponder];
    [_txtOffer resignFirstResponder];
    
    
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
