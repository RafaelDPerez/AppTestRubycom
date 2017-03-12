//
//  MapsViewController.m
//  AppTest
//
//  Created by Rafael Perez on 8/30/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "MapsViewController.h"
#import "VKSideMenu.h"

@interface MapsViewController (){
    NSArray *recipeImages;
}
@property (nonatomic, strong) VKSideMenu *menuLeft;
@end

@implementation MapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    self.menuLeft = [[VKSideMenu alloc] initWithSize:280 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.view];
    self.menuLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];

    
//    CLLocationCoordinate2D location;
//    
//    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
//    NSString *lat = @"6.469438";
//    NSString *longitude = @"3.578921";
//    location.latitude = lat.doubleValue;
//    location.longitude = longitude.doubleValue;
//    point1.coordinate = CLLocationCoordinate2DMake(lat.doubleValue, longitude.doubleValue);
//    point1.title = @"AP Filling Station";
//    [self.mapView addAnnotation:point1];
//    
//    MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
//    NSString *lat2 = @"6.546609";
//    NSString *longitude2 = @"3.238251";
//    location.latitude = lat2.doubleValue;
//    location.longitude = longitude2.doubleValue;
//    point2.coordinate = CLLocationCoordinate2DMake(lat2.doubleValue, longitude2.doubleValue);
//    point2.title = @"AP Filling Station";
//    [self.mapView addAnnotation:point2];
//    
//    MKPointAnnotation *point3 = [[MKPointAnnotation alloc] init];
//    NSString *lat3 = @"6.608219";
//    NSString *longitude3 = @"3.362096";
//    location.latitude = lat3.doubleValue;
//    location.longitude = longitude3.doubleValue;
//    point3.coordinate = CLLocationCoordinate2DMake(lat3.doubleValue, longitude3.doubleValue);
//    point3.title = @"AP Filling Station";
//    [self.mapView addAnnotation:point3];
//    
//    MKPointAnnotation *point4 = [[MKPointAnnotation alloc] init];
//    NSString *lat4 = @"6.558039";
//    NSString *longitude4 = @"3.331197";
//    location.latitude = lat4.doubleValue;
//    location.longitude = longitude4.doubleValue;
//    point4.coordinate = CLLocationCoordinate2DMake(lat4.doubleValue, longitude4.doubleValue);
//    point4.title = @"Mobil";
//    [self.mapView addAnnotation:point4];
//    
//    MKPointAnnotation *point5 = [[MKPointAnnotation alloc] init];
//    NSString *lat5 = @"6.559405";
//    NSString *longitude5 = @"3.350267";
//    location.latitude = lat5.doubleValue;
//    location.longitude = longitude5.doubleValue;
//    point5.coordinate = CLLocationCoordinate2DMake(lat5.doubleValue, longitude5.doubleValue);
//    point5.title = @"AP Filling Station";
//    [self.mapView addAnnotation:point5];
//    
//    MKPointAnnotation *point6 = [[MKPointAnnotation alloc] init];
//    NSString *lat6 = @"6.545628";
//    NSString *longitude6 = @"3.39403";
//    location.latitude = lat6.doubleValue;
//    location.longitude = longitude6.doubleValue;
//    point6.coordinate = CLLocationCoordinate2DMake(lat6.doubleValue, longitude6.doubleValue);
//    point6.title = @"Mrs Filling Station";
//    [self.mapView addAnnotation:point6];
//    
//    MKPointAnnotation *point7 = [[MKPointAnnotation alloc] init];
//    NSString *lat7 = @"6.524379";
//    NSString *longitude7 = @"3.379206";
//    location.latitude = lat7.doubleValue;
//    location.longitude = longitude7.doubleValue;
//    point7.coordinate = CLLocationCoordinate2DMake(lat7.doubleValue, longitude7.doubleValue);
//    point7.title = @"AP Filling Station";
//    [self.mapView addAnnotation:point7];
    
    //CLLocationCoordinate2D NigCoord = CLLocationCoordinate2DMake(10.438520, 8.876953);
    CLLocationCoordinate2D LagosCoord = CLLocationCoordinate2DMake(6.524379, 3.379206);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(LagosCoord, 8000, 8000);
    [self.mapView setRegion:region animated:YES];
    

}

-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    if ([segue.identifier isEqualToString:@"ViewOffer"]) {
//        OfferViewController *offerViewController = [segue destinationViewController];
//        //     [cell getCurrentIndex];
//        offerViewController.hola= [recipeImages objectAtIndex:index];
//        offerViewController.Offer = [commerceClicked.CommerceOffers objectAtIndex:index];
//        
//    }
    if ([segue.identifier isEqualToString:@"callHomeFromMap"]) {
        
        //     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //        ProfileViewController *leftMenu = (ProfileViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
        //        [SlideNavigationController sharedInstance].leftMenu = leftMenu;
        //        [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    }
    if ([segue.identifier isEqualToString:@"callMap"]) {
        [self removeFromParentViewController];
    }
    
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

//-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
//    
//    
//}


#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
       [self performSegueWithIdentifier:@"callHomeFromMap" sender:self];
//        [self removeFromParentViewController];
//        [self.view removeFromSuperview];
// [self performSegueWithIdentifier:@"undwindToHome" sender:self];
    
    }
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"callMap" sender:self];
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


//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    static NSString *identifier = @"MyLocation";
//    //MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView ];
//    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//    annotationView.annotation = annotation;
//    annotationView.enabled = YES;
//    annotationView.canShowCallout = YES;
//    annotationView.image = [UIImage imageNamed:@"tag"];
//    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    return annotationView;
//}
//
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    //MyLocation *location = (MyLocation*)view.annotation;
//    MKPointAnnotation *hola = [[MKPointAnnotation alloc] init];
//    hola = view.annotation;
//    MKPlacemark *placemark = [[MKPlacemark alloc]
//                              initWithCoordinate:hola.coordinate
//                              addressDictionary:nil];
//    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    mapItem.name = hola.title;
//    
//    
//    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
//    [mapItem openInMapsWithLaunchOptions:launchOptions];
//}








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
