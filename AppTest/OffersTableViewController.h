//
//  OffersTableViewController.h
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "KASlideShow.h"

@interface OffersTableViewController : UITableViewController<SlideNavigationControllerDelegate,KASlideShowDelegate,KASlideShowDataSource>

-(void)callLogIn;
@end
