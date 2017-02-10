//
//  KITableViewCell.h
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"

@interface KITableViewCell : UITableViewCell<KASlideShowDelegate,KASlideShowDataSource>
@property(weak, nonatomic) IBOutlet UILabel *txtName;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;
@property (strong,nonatomic) IBOutlet UIButton * btnPrev;
@property (strong,nonatomic) IBOutlet UIButton * btnNext;
@property (strong,nonatomic) IBOutlet UIButton * btnLike;
@property NSUInteger *selectedIndex;
-(void)setSlideShow:(NSString*)img;
-(NSUInteger*)getCurrentIndex;
@end
