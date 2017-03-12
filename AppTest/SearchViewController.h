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
@property (weak, nonatomic) IBOutlet UISlider *sldBIXIPoints;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) CommerceType *commerceTypeSelected;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;


@end
