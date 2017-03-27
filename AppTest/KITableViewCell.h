//
//  KITableViewCell.h
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"

@interface KITableViewCell : UITableViewCell<KASlideShowDelegate,KASlideShowDataSource>{
@public int selectedIndex;
}
@property(weak, nonatomic) IBOutlet UILabel *txtName;
@property(weak, nonatomic) IBOutlet UILabel *txtAddress;
@property(weak, nonatomic) IBOutlet UILabel *lblPoints;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;
@property (strong,nonatomic) IBOutlet UIButton * btnPrev;
@property (strong,nonatomic) IBOutlet UIButton * btnNext;
@property (strong,nonatomic) IBOutlet UIButton * btnLike;
@property (weak, nonatomic) KASlideShow *hola;

-(void)setSlideShow:(NSString*)img;
-(void)getCurrentIndex;
@end
