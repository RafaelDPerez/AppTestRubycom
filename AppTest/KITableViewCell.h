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
@property(weak, nonatomic) IBOutlet UITextView *txtName;
@property(weak, nonatomic) IBOutlet UITextView *txtDescription;
@property(weak, nonatomic) IBOutlet UILabel *lblPoints;
@property (strong,nonatomic) IBOutlet KASlideShow * slideshow;

@property (strong,nonatomic) UIButton * btnPrev;
@property (strong,nonatomic) UIButton * btnNext;
@property (strong,nonatomic) UIButton * btnLike;
@property (weak, nonatomic) KASlideShow *hola;
@property (weak, nonatomic) NSMutableArray *Offers;
@property int offerIndex;
-(void)setSlideShow:(NSString*)img;
-(void)receiveOffers:(NSMutableArray*)offers;
-(int)getCurrentIndex;
-(void)NextImg;
-(void)PrevImg;
@end
