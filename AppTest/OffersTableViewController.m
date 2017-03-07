//
//  OffersTableViewController.m
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "OffersTableViewController.h"
#import "FDKeychain.h"
#import "OfferViewController.h"
#import "KITableViewCell.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "VKSideMenu.h"
#import "FDKeyChain.h"
@import GoogleSignIn;
#import "Commerce.h"
#import "Offer.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

@interface OffersTableViewController() <VKSideMenuDelegate, VKSideMenuDataSource>{
    NSArray *recipeImages;
    KASlideShow *slideshow;
    NSArray *imgs;
    KITableViewCell *cell;
    //NSUInteger *index;
}

@property (nonatomic, strong) VKSideMenu *menuLeft;
@end

@implementation OffersTableViewController
@synthesize commercesArray, commerceSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    commercesArray = [[NSMutableArray alloc] init];
    // **GET PRODUCTS**
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
    NSLog(@"%@", token);
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/search_products/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    NSData *jsonData = [@"{\"search\":NULL }"dataUsingEncoding:NSUTF8StringEncoding];
    [rq setHTTPBody:jsonData];
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
         if ([message isEqualToString:@"OK"]) {
             NSArray *result = [json objectForKey:@"result"];
             for (int i = 0; i<= result.count - 1; i++) {
                 //now let's dig out each and every json object
                 Commerce *commerce = [[Commerce alloc]init];
                 NSDictionary *dict = [result objectAtIndex:i];
                 commerce.CommerceAddress = [dict objectForKey:@"commerce_address"];
                 commerce.CommerceID = [dict objectForKey:@"commerce_id"];
                 commerce.CommerceLat = [dict objectForKey:@"commerce_lat"];
                 commerce.CommerceLng = [dict objectForKey:@"commerce_lng"];
                 commerce.CommerceName = [dict objectForKey:@"commerce_name"];
                 commerce.CommerceOffers = [[NSMutableArray alloc]init];
                 NSArray *offers = [dict objectForKey:@"products"];
                 NSArray *dict2 = [offers objectAtIndex:0];
                 for (int j=0; j<=dict2.count -1; j++) {
                     Offer *offer = [[Offer alloc]init];
                     NSDictionary *dict3 = [dict2 objectAtIndex:j];
                     offer.OfferExpirationDate = [dict3 objectForKey:@"date_expires"];
                     offer.OfferDescription = [dict3 objectForKey:@"description"];
                     offer.OfferImage = [dict3 objectForKey:@"images"];
                     offer.IsOffer = [dict3 objectForKey:@"is_offer"];
                     offer.OfferName = [dict3 objectForKey:@"name"];
                     offer.OfferPoints = [dict3 objectForKey:@"points"];
                     offer.OfferID = [dict3 objectForKey:@"product_id"];
                     offer.OfferQuantity = [dict3 objectForKey:@"quantity"];
                     offer.OfferStatus = [dict3 objectForKey:@"status"];
                     [commerce.CommerceOffers addObject:offer];
                 }
                 [commercesArray addObject:commerce];
                 [self.tableView reloadData];
                 //commerce.CommerceImage = [dict objectForKey:@"image"];
                 
             }
             
             NSLog(@"codigo: %@", result);
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
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
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

    recipeImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

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
        return 5;
    
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
                item.title = @"Configuración";
                item.icon  = [UIImage imageNamed:@"ic_option_4"];
                break;
                
            case 4:
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
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        
    }
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"callMap" sender:self];
    }
    if (indexPath.row ==4) {
        [self logOut:self];
    }
    NSLog(@"SideMenu didSelectRow: %@", indexPath);
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


-(IBAction)logOut:(id)sender{
    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [self performSegueWithIdentifier:@"backLogIn" sender:self];
    [[GIDSignIn sharedInstance] signOut];
    
}

-(void)callLogIn{
//[self performSegueWithIdentifier:@"backLogIn" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ViewOffer"]) {
        OfferViewController *offerViewController = [segue destinationViewController];
   //     [cell getCurrentIndex];
        offerViewController.hola= [recipeImages objectAtIndex:index];
        offerViewController.Offer = [commerceSelected.CommerceOffers objectAtIndex:index];
        
    }
    if ([segue.identifier isEqualToString:@"backLogIn"]) {
        //     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        ProfileViewController *leftMenu = (ProfileViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
        //        [SlideNavigationController sharedInstance].leftMenu = leftMenu;
        //        [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    }
    if ([segue.identifier isEqualToString:@"callMap"]) {
        
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
    [cell setSlideShow:@[@"336D.jpg",@"test_1.jpg",@"test_2.jpg",@"test_3.jpg",@"test_4.jpg",@"336D.jpg",@"test_1.jpg",@"test_2.jpg"]];

            
    //cell.slideshow = slideshow;
    commerceSelected = [commercesArray objectAtIndex:indexPath.row];
    cell.txtName.text = commerceSelected.CommerceName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
