//
//  MapsViewController.m
//  AppTest
//
//  Created by Rafael Perez on 8/30/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "MapsViewController.h"

@interface MapsViewController (){
    NSArray *recipeImages;
}

@end

@implementation MapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        recipeImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
    
    CLLocationCoordinate2D location;
    
    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
    NSString *lat = @"6.469438";
    NSString *longitude = @"3.578921";
    location.latitude = lat.doubleValue;
    location.longitude = longitude.doubleValue;
    point1.coordinate = CLLocationCoordinate2DMake(lat.doubleValue, longitude.doubleValue);
    point1.title = @"AP Filling Station";
    [self.mapView addAnnotation:point1];
    
    MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
    NSString *lat2 = @"6.546609";
    NSString *longitude2 = @"3.238251";
    location.latitude = lat2.doubleValue;
    location.longitude = longitude2.doubleValue;
    point2.coordinate = CLLocationCoordinate2DMake(lat2.doubleValue, longitude2.doubleValue);
    point2.title = @"AP Filling Station";
    [self.mapView addAnnotation:point2];
    
    MKPointAnnotation *point3 = [[MKPointAnnotation alloc] init];
    NSString *lat3 = @"6.608219";
    NSString *longitude3 = @"3.362096";
    location.latitude = lat3.doubleValue;
    location.longitude = longitude3.doubleValue;
    point3.coordinate = CLLocationCoordinate2DMake(lat3.doubleValue, longitude3.doubleValue);
    point3.title = @"AP Filling Station";
    [self.mapView addAnnotation:point3];
    
    MKPointAnnotation *point4 = [[MKPointAnnotation alloc] init];
    NSString *lat4 = @"6.558039";
    NSString *longitude4 = @"3.331197";
    location.latitude = lat4.doubleValue;
    location.longitude = longitude4.doubleValue;
    point4.coordinate = CLLocationCoordinate2DMake(lat4.doubleValue, longitude4.doubleValue);
    point4.title = @"Mobil";
    [self.mapView addAnnotation:point4];
    
    MKPointAnnotation *point5 = [[MKPointAnnotation alloc] init];
    NSString *lat5 = @"6.559405";
    NSString *longitude5 = @"3.350267";
    location.latitude = lat5.doubleValue;
    location.longitude = longitude5.doubleValue;
    point5.coordinate = CLLocationCoordinate2DMake(lat5.doubleValue, longitude5.doubleValue);
    point5.title = @"AP Filling Station";
    [self.mapView addAnnotation:point5];
    
    MKPointAnnotation *point6 = [[MKPointAnnotation alloc] init];
    NSString *lat6 = @"6.545628";
    NSString *longitude6 = @"3.39403";
    location.latitude = lat6.doubleValue;
    location.longitude = longitude6.doubleValue;
    point6.coordinate = CLLocationCoordinate2DMake(lat6.doubleValue, longitude6.doubleValue);
    point6.title = @"Mrs Filling Station";
    [self.mapView addAnnotation:point6];
    
    MKPointAnnotation *point7 = [[MKPointAnnotation alloc] init];
    NSString *lat7 = @"6.524379";
    NSString *longitude7 = @"3.379206";
    location.latitude = lat7.doubleValue;
    location.longitude = longitude7.doubleValue;
    point7.coordinate = CLLocationCoordinate2DMake(lat7.doubleValue, longitude7.doubleValue);
    point7.title = @"AP Filling Station";
    [self.mapView addAnnotation:point7];
    
    //CLLocationCoordinate2D NigCoord = CLLocationCoordinate2DMake(10.438520, 8.876953);
    CLLocationCoordinate2D LagosCoord = CLLocationCoordinate2DMake(6.524379, 3.379206);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(LagosCoord, 8000, 8000);
    [self.mapView setRegion:region animated:YES];
    

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    //MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView ];
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    annotationView.annotation = annotation;
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.image = [UIImage imageNamed:@"Price Tag Filled-50"];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    //MyLocation *location = (MyLocation*)view.annotation;
    MKPointAnnotation *hola = [[MKPointAnnotation alloc] init];
    hola = view.annotation;
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:hola.coordinate
                              addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = hola.title;
    
    
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    [mapItem openInMapsWithLaunchOptions:launchOptions];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return recipeImages.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];
    
    
    return cell;
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
