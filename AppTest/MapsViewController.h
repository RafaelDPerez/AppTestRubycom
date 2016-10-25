//
//  MapsViewController.h
//  AppTest
//
//  Created by Rafael Perez on 8/30/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapsViewController : UIViewController<MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) IBOutlet UICollectionView *dealsView;
@property (strong,nonatomic) NSMutableArray *stationsArray;

@end
