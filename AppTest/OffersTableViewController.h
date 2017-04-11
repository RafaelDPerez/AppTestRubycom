//
//  OffersTableViewController.h
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"
#import "Commerce.h"

@interface OffersTableViewController : UITableViewController<KASlideShowDelegate,KASlideShowDataSource>{
@public int index;
}
@property (strong,nonatomic) NSMutableArray *commercesArray;
@property (weak, nonatomic) Commerce *commerceSelected;
@property (weak, nonatomic) Commerce *commerceClicked;
@property (strong, nonatomic) NSMutableArray *urlArray;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSIndexPath *indexPathCell;

-(void)callLogIn;
@end
