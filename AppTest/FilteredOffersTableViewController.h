//
//  FilteredOffersTableViewController.h
//  AppTest
//
//  Created by Rafael Perez on 3/12/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"
#import "Commerce.h"


@interface FilteredOffersTableViewController : UITableViewController<KASlideShowDelegate,KASlideShowDataSource>{
@public int index;
}
@property (strong,nonatomic) NSMutableArray *commercesArray;
@property (weak, nonatomic) Commerce *commerceSelected;
@property (weak, nonatomic) Commerce *commerceClicked;
@property (weak, nonatomic) NSString *location;
@property (weak, nonatomic) NSString *BIXIPoints;
@property (weak, nonatomic) NSString *commerceType;
@property (weak, nonatomic) NSString *orderBy;

@property (strong, nonatomic) NSMutableArray *urlArray;
@property (strong, nonatomic) NSMutableArray *imageArray;

-(void)callLogIn;

@end
