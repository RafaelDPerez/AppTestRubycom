//
//  FilteredOffersTableViewController.m
//  AppTest
//
//  Created by Rafael Perez on 3/12/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "FilteredOffersTableViewController.h"#import "FDKeychain.h"
#import "OfferViewController.h"
#import "KITableViewCell.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "VKSideMenu.h"
#import "FDKeyChain.h"
@import GoogleSignIn;
#import "Commerce.h"
#import "Offer.h"
#import "SDWebImage/UIImageView+WebCache.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

@interface FilteredOffersTableViewController () <VKSideMenuDelegate, VKSideMenuDataSource, UIAlertViewDelegate>{
    NSMutableArray *recipeImages;
    KASlideShow *slideshow;
    NSArray *imgs;
    KITableViewCell *cell;
    //NSUInteger *index;
    NSString *loggedInFiltered;
}

@property (nonatomic, strong) VKSideMenu *menuLeft;
@end

@implementation FilteredOffersTableViewController
@synthesize commercesArray, commerceSelected, commerceClicked, urlArray, imageArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    recipeImages = [[NSMutableArray alloc]init];
    recipeImages = [NSMutableArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
    urlArray =[[NSMutableArray alloc] init];
    imageArray=[[NSMutableArray alloc] init];
    commercesArray = [[NSMutableArray alloc] init];
    // **GET PRODUCTS**
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
    NSLog(@"%@", token);
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/search_products/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
  //  NSData *jsonData = [@"{\"search\":NULL }"dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSData *jsonData = [[NSString stringWithFormat:@"{\"type_commerce_id\":\"%@\",\"search\":\"%@\",\"order_by\":\"%@\",\"is_offer\":\"%@\",\"start\":\"%d\",\"point_from\":\"%d\",\"point_to\":\"%@\",\"distance\":\"%d\",\"lat\":\"%d\",\"lng\":\"%d\"}", self.commerceType, self.location, self.orderBy, @"", 0 ,10,self.BIXIPoints, 10, 0, 0] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *jsonData = [[NSString stringWithFormat:@"{\"type_commerce_id\":\"%@\",\"search\":\"%@\",\"order_by\":\"%@\",\"is_offer\":\"%@\",\"start\":\"%d\",\"point_from\":\"%d\",\"point_to\":\"%@\"}", self.commerceType, self.location, self.orderBy, @"", 0 ,10,self.BIXIPoints] dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSData *jsonData = [[NSString stringWithFormat:@"{\"search\":\"%@\"}",self.location] dataUsingEncoding:NSUTF8StringEncoding];
    
    [rq setHTTPBody:jsonData];
    // [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
    
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
         NSLog(@"%@",result);
         if ([result count]!=0) {
             if ([message isEqualToString:@"OK"]) {
                 NSArray *result = [json objectForKey:@"result"];
                 for (int i = 0; i<= result.count - 1; i++) {
                     //now let's dig out each and every json object
                     Commerce *commerce = [[Commerce alloc]init];
                     commerce.CommerceOffersImages = [[NSMutableArray alloc]init];
                     NSDictionary *dict = [result objectAtIndex:i];
                     commerce.CommerceAddress = [dict objectForKey:@"commerce_address"];
                     commerce.CommerceID = [dict objectForKey:@"commerce_id"];
                     commerce.CommerceLat = [dict objectForKey:@"commerce_lat"];
                     commerce.CommerceLng = [dict objectForKey:@"commerce_lng"];
                     commerce.CommerceName = [dict objectForKey:@"commerce_name"];
                     commerce.CommerceOffers = [[NSMutableArray alloc]init];
                     NSArray *offers = [dict objectForKey:@"products"];
                     //  NSArray *dict2 = [offers objectAtIndex:0];
                     for (int j=0; j<=offers.count -1; j++) {
                         Offer *offer = [[Offer alloc]init];
                         NSDictionary *dict3 = [offers objectAtIndex:j];
                         offer.OfferExpirationDate = [dict3 objectForKey:@"date_expires"];
                         offer.OfferDescription = [dict3 objectForKey:@"description"];
                         offer.OfferImage = [dict3 objectForKey:@"images"];
                         offer.IsOffer = [dict3 objectForKey:@"is_offer"];
                         offer.OfferName = [dict3 objectForKey:@"name"];
                         offer.OfferPoints = [dict3 objectForKey:@"points"];
                         offer.OfferID = [dict3 objectForKey:@"product_id"];
                         offer.OfferQuantity = [dict3 objectForKey:@"quantity"];
                         offer.OfferStatus = [dict3 objectForKey:@"status"];
                         offer.OfferImage = [NSMutableArray arrayWithArray:[dict3 objectForKey:@"images"]];
                         if ([offer.OfferImage count]==0) {
                             [offer.OfferImage addObject:@"http://www.bestprintingonline.com/help_resources/Image/Ducky_Head_Web_Low-Res.jpg"];
                             [commerce.CommerceOffersImages addObject:@"http://www.bestprintingonline.com/help_resources/Image/Ducky_Head_Web_Low-Res.jpg"];
                         }
                         else
                             [commerce.CommerceOffersImages addObject:offer.OfferImage[0]];
                          [commerce.CommerceOffers addObject:offer];
                         //                     [urlArray addObject:@"http://www.bestprintingonline.com/help_resources/Image/Ducky_Head_Web_Low-Res.jpg"];
                         
                     }
                     
                     //                 for (int i =0; i<urlArray.count; i++) {
                     //                     NSURL *url = [NSURL URLWithString:[self.urlArray firstObject]];
                     //                     SDWebImageManager *manager = [SDWebImageManager sharedManager];
                     //                     [manager downloadImageWithURL:url
                     //                                           options:0
                     //                                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     //                                              // progression tracking code
                     //                                          }
                     //                                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                     //                                             if (image) {
                     //                                                 [imageArray addObject:image];
                     //                                                 //[urlArray removeObjectAtIndex:0];
                     //                                                 // [self downloadImage];
                     //                                             }
                     //                                             else {
                     //                                                 //  [self downloadImage]; //try download once again
                     //                                             }
                     //                                         }];
                     //                 }
                     //                 commerce.CommerceOffersImages = imageArray;
                     //[imageArray removeAllObjects];
                     // [urlArray removeAllObjects];
                     [commercesArray addObject:commerce];
                     
                     [self.tableView reloadData];
                     //commerce.CommerceImage = [dict objectForKey:@"image"];
                     
                 }
                 
                 NSLog(@"codigo: %@", result);
             }

         }
         
     }];
    
    self.menuLeft = [[VKSideMenu alloc] initWithSize:280 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.view];
    self.menuLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    // NSString *token = [FDKeychain itemForKey:@"usertoken" forService:@"BIXI" error:nil];
    NSString *loggedin = [FDKeychain itemForKey:@"loggedin" forService:@"BIXI" error:nil];
    NSLog(@"token:%@", token);
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoBixi2"]];
    self.tableView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    // Initialize recipe image array
    imgs = @[
             @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen1.png",
             @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen2.png",
             @"https://raw.github.com/kimar/tapebooth/master/Screenshots/Screen3.png"
             ];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender {
//    [fromViewController dismissViewControllerAnimated:YES completion:nil];
//
//    return YES;
//
//}
//
//
//-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
//
//
//}


-(void)downloadImage {
    for (int i =0; i<urlArray.count; i++) {
        NSURL *url = [NSURL URLWithString:[self.urlArray firstObject]];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:url
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    [imageArray addObject:image];
                                    //[urlArray removeObjectAtIndex:0];
                                    // [self downloadImage];
                                }
                                else {
                                    //  [self downloadImage]; //try download once again
                                }
                            }];
    }
    
}

//    if (urlArray.count > 0) {
//        }

-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return (sideMenu == self.menuLeft) ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 7;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    loggedInFiltered = [FDKeychain itemForKey: @"loggedin"
                           forService: @"BIXI"
                                error: nil];
    if ([loggedInFiltered isEqualToString:@"YES"]){
        
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
                    item.title = @"Agregar Puntos";
                    item.icon  = [UIImage imageNamed:@"Add-50"];
                    
                    break;
                    
                case 3:
                    item.title = @"Ofertas que me gustan";
                    item.icon  = [UIImage imageNamed:@"Like-50"];
                    break;
                    
                case 4:
                    item.title = @"Ofertas cerca de mí";
                    item.icon  = [UIImage imageNamed:@"Near Me-50"];
                    break;
                    
                case 5:
                    item.title = @"Transacciones";
                    item.icon  = [UIImage imageNamed:@"Transaction List-50"];
                    
                    break;
                    
                case 6:
                    item.title = @"Salir";
                    item.icon  = [UIImage imageNamed:@"Exit-50"];
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
    }
    else{
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
                    item.title = @"Agregar Puntos";
                    item.icon  = [UIImage imageNamed:@"Add-50"];
                    
                    break;
                    
                case 3:
                    item.title = @"Ofertas que me gustan";
                    item.icon  = [UIImage imageNamed:@"Like-50"];
                    break;
                    
                case 4:
                    item.title = @"Ofertas cerca de mí";
                    item.icon  = [UIImage imageNamed:@"Near Me-50"];
                    break;
                    
                case 5:
                    item.title = @"Transacciones";
                    item.icon  = [UIImage imageNamed:@"Transaction List-50"];
                    
                    break;
                    
                case 6:
                    item.title = @"Iniciar Sesión";
                    item.icon  = [UIImage imageNamed:@"Circled User Male-50"];
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
        
    }
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row ==0) {
//        [self performSegueWithIdentifier:@"callHomeFiltered" sender:self];
//    }
//    if (indexPath.row == 1) {
//        [self performSegueWithIdentifier:@"callProfile" sender:self];
//    }
//    if (indexPath.row ==2) {
//        [self performSegueWithIdentifier:@"callMap" sender:self];
//        //        [self dismissViewControllerAnimated:YES completion:nil];
//        //        [self removeFromParentViewController];
//        //        [self.view removeFromSuperview];
//    }
//    if (indexPath.row ==4) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle: @"Salir"
//                              message: @"Está seguro que desea salir de BIXI?"
//                              delegate: self
//                              cancelButtonTitle:@"NO"
//                              otherButtonTitles:@"SI",nil];
//        [alert show];
//        
//    }
//    NSLog(@"SideMenu didSelectRow: %@", indexPath);
    
    loggedInFiltered = [FDKeychain itemForKey: @"loggedin"
                           forService: @"BIXI"
                                error: nil];
    if ([loggedInFiltered isEqualToString:@"YES"]){
        if (indexPath.row ==0) {
            [self performSegueWithIdentifier:@"callHomeFiltered" sender:self];
        }
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"callProfileFiltered" sender:self];
        }
        if (indexPath.row ==2) {
            [self performSegueWithIdentifier:@"callAddPointsFiltered" sender:self];
            
            //        [self dismissViewControllerAnimated:YES completion:nil];
            //        [self removeFromParentViewController];
            //        [self.view removeFromSuperview];
        }
        if (indexPath.row == 3) {
            [self performSegueWithIdentifier:@"callFavoritesFiltered" sender:self];
        }
        
        if (indexPath.row == 4) {
            [self performSegueWithIdentifier:@"callMapFiltered" sender:self];
        }
        
        if (indexPath.row ==6) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Salir"
                                  message: @"Está seguro que desea salir de BIXI?"
                                  delegate: self
                                  cancelButtonTitle:@"NO"
                                  otherButtonTitles:@"SI",nil];
            [alert show];
            
        }
        if (indexPath.row == 5) {
            [self performSegueWithIdentifier:@"callTransactionsFiltered" sender:self];
        }
        NSLog(@"SideMenu didSelectRow: %@", indexPath);
    }
    else{
        if (indexPath.row ==0) {
            [self performSegueWithIdentifier:@"callHomeFiltered" sender:self];
        }
        if (indexPath.row == 1) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            //[self performSegueWithIdentifier:@"callProfile" sender:self];
        }
        if (indexPath.row ==2) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            //[self performSegueWithIdentifier:@"callFavorites" sender:self];
            
            //        [self dismissViewControllerAnimated:YES completion:nil];
            //        [self removeFromParentViewController];
            //        [self.view removeFromSuperview];
        }
        if (indexPath.row == 4) {
            [self performSegueWithIdentifier:@"callMap" sender:self];
        }
        
        if (indexPath.row ==3) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            
        }
        if (indexPath.row == 5) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            //[self performSegueWithIdentifier:@"callTransactions" sender:self];
        }
        
        if (indexPath.row == 6) {
            [self performSegueWithIdentifier:@"callRegisterHome" sender:self];
        }
        NSLog(@"SideMenu didSelectRow: %@", indexPath);
        
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"BIXI"]) {
        if (buttonIndex == 1) {
            [self performSegueWithIdentifier:@"callRegisterHome" sender:self];
        }
        else {
            
        }
    }
    else{
        if (buttonIndex == 1) {
            [self logOut:self];
        }
        else {
            
        }
    }
}

-(IBAction)logOut:(id)sender{
    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    //[self performSegueWithIdentifier:@"backLogIn" sender:self];
    [[GIDSignIn sharedInstance] signOut];
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


//-(IBAction)logOut:(id)sender{
//    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
//    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    [loginManager logOut];
//    
//    [FBSDKAccessToken setCurrentAccessToken:nil];
//    [self performSegueWithIdentifier:@"backLogIn" sender:self];
//    [[GIDSignIn sharedInstance] signOut];
//    
//}

-(void)callLogIn{
    //[self performSegueWithIdentifier:@"backLogIn" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ViewOffer"]) {
        OfferViewController *offerViewController = [segue destinationViewController];
        //     [cell getCurrentIndex];
        offerViewController.hola= [recipeImages objectAtIndex:index];
        offerViewController.offer = [commerceClicked.CommerceOffers objectAtIndex:index];
        
    }
    if ([segue.identifier isEqualToString:@"backLogIn"]) {
        //     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        ProfileViewController *leftMenu = (ProfileViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
        //        [SlideNavigationController sharedInstance].leftMenu = leftMenu;
        //        [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    }
    if ([segue.identifier isEqualToString:@"callMap"]) {
        [self removeFromParentViewController];
    }
    
}
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return commercesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell = (KITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"imgCell" forIndexPath:indexPath];
    
    
    
//    //cell.slideshow = slideshow;
//    commerceSelected = [commercesArray objectAtIndex:indexPath.row];
//    [cell setSlideShow:commerceSelected.CommerceOffersImages];
//    cell.txtName.text = commerceSelected.CommerceName;
//    cell.txtDescription.text = commerceSelected.CommerceAddress;
//    
//    return cell;
    
    //cell.slideshow = slideshow;
    commerceSelected = [commercesArray objectAtIndex:indexPath.row];
    NSMutableArray *hello = [[NSMutableArray alloc]init];
    hello = commerceSelected.CommerceOffers;
    [cell setSlideShow:commerceSelected.CommerceOffersImages];
    [cell receiveOffers:commerceSelected.CommerceOffers];
    cell.txtName.text = commerceSelected.CommerceName;
    Offer *hay = [[Offer alloc]init];
    hay = [hello objectAtIndex:index];
    cell.txtDescription.text = hay.OfferDescription;
    Offer *hola = [[Offer alloc]init];
    hola = [commerceSelected.CommerceOffers objectAtIndex:0];
    cell.lblPoints.text = hola.OfferPoints;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    commerceClicked = [commercesArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewOffer" sender:self];
    
    
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
