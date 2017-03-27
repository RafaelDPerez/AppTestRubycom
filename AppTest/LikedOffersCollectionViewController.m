//
//  LikedOffersCollectionViewController.m
//  AppTest
//
//  Created by Rafael Perez on 3/25/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "LikedOffersCollectionViewController.h"
#import "FDKeyChain.h"
#import "Offer.h"
#import "VKSideMenu.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "FavoritesCollectionViewCell.h"
#import "OfferViewController.h"

@interface LikedOffersCollectionViewController ()<VKSideMenuDelegate, VKSideMenuDataSource>
@property (nonatomic, strong) VKSideMenu *menuLeft;
@end

@implementation LikedOffersCollectionViewController
@synthesize offersArray, offerClicked, offerSelected;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    self.menuLeft = [[VKSideMenu alloc] initWithSize:280 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
  //  [self.menuLeft addSwipeGestureRecognition:self.navigationController.view];
    self.menuLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    offersArray = [[NSMutableArray alloc] init];
    offerSelected = [[Offer alloc]init];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];

    
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/favorites/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    
    
    [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
    [NSURLConnection sendAsynchronousRequest:rq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSError* error;
         NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
         NSArray *sceResponseCode = [json objectForKey:@"sceResponseCode"];
         
         NSLog(@"codigo: %@", sceResponseCode);
         NSString *message = [json objectForKey:@"sceResponseMsg"];
         NSArray *result = [json objectForKey:@"result"];
         NSDictionary *holis = [json objectForKey:@"result"];
         NSLog(@"%@",result);
         if ([message isEqualToString:@"OK"]) {
             NSArray *result = [json objectForKey:@"result"];
             for (int i = 0; i<= result.count - 1; i++) {
                 //now let's dig out each and every json object
                     Offer *offer = [[Offer alloc]init];
                     NSDictionary *dict3 = [result objectAtIndex:i];
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
                 }

                   //  offer.OfferImage = @"http://www.bestprintingonline.com/help_resources/Image/Ducky_Head_Web_Low-Res.jpg";
                 [offersArray addObject:offer];
                 
             }
             [self.collectionView reloadData];
                 //commerce.CommerceImage = [dict objectForKey:@"image"];
                 
             }

         
         
      }];
    
         // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return offersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FavoritesCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"CellFavorite"forIndexPath:indexPath]
    ;
    if (offersArray.count>0) {
        Offer *thisOffer = [[Offer alloc]init];
        thisOffer = [offersArray objectAtIndex:indexPath.row];
        
        cell.lblOfferPoints.text = thisOffer.OfferPoints;
        cell.lblOfferName.text = thisOffer.OfferName;
        cell.btnDislike.tag = indexPath.row;
        //NSArray *images = thisOffer.OfferImage;
        
        [cell.ivOfferImage sd_setImageWithURL:[NSURL URLWithString:[thisOffer.OfferImage objectAtIndex:0]]
                     placeholderImage:[UIImage imageNamed:@"Garage-50"]];
    }
//    UIImageView *offerImageView = (UIImageView *)[cell viewWithTag:100];
   
        //cell.
    // Configure the cell
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    offerSelected = [offersArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewOffer" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ViewOffer"]) {
        OfferViewController *offerViewController = [segue destinationViewController];
        //     [cell getCurrentIndex];
//        offerViewController.hola= offerSelected.OfferImage;
        offerViewController.offer = offerSelected;
        
    }
  
    
}

-(IBAction)DislikeOffer:(UIButton*)sender{
    Offer *dislikedOffer = [[Offer alloc]init];
    dislikedOffer = [offersArray objectAtIndex:sender.tag];
    NSLog(@" Este es el sender: %ld",(long)sender.tag);
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/quit_favorites/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
    NSData *jsonData = [[NSString stringWithFormat:@"{\"product_id\":\"%@\"}", dislikedOffer.OfferID] dataUsingEncoding:NSUTF8StringEncoding];
    
    [rq setHTTPBody:jsonData];
    
    [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
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
                 NSLog(@"it's deleted");
         }
         
         }];

    
    [offersArray removeObject:[offersArray objectAtIndex:sender.tag]];
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:sender.tag inSection:0];
    [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
    [self.collectionView reloadData];

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
        [self performSegueWithIdentifier:@"callHomeProfile" sender:self];
    }
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"callProfile" sender:self];
    }
    if (indexPath.row ==2) {
        [self performSegueWithIdentifier:@"callMap" sender:self];
    }
    if (indexPath.row ==4) {
        // [self logOut:self];
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

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
