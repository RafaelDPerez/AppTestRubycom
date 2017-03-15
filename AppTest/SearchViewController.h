//
//  SearchViewController.h
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommerceType.h"


@interface SearchViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *sldBIXIPoints;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) CommerceType *commerceTypeSelected;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;


@end
