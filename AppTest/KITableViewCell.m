//
//  KITableViewCell.m
//  AppTest
//
//  Created by Rafael Perez on 2/9/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "KITableViewCell.h"
#import "FDKeychain.h"
#import "OffersTableViewController.h"
#import "OffersTableViewController.h"
#import "Offer.h"

@implementation KITableViewCell{
    KASlideShow *hola;
    UITableView *tv;
    OffersTableViewController *vc;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(void)setSlideShow:(NSArray*)imgs{

    
    _btnLike = [[UIButton alloc]init];
    [_btnLike setImage:[UIImage imageNamed:@"Like-50"] forState:UIControlStateNormal];
    _btnLike.frame = CGRectMake(self.bounds.size.width - 68, self.bounds.origin.y + 10.0f, 50.0f, 35.0f);
    //[_btnLike addTarget:self action:@selector(PrevImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btnLike];
    
    _btnPrev = [[UIButton alloc]init];
    [_btnPrev setImage:[UIImage imageNamed:@"Back Filled-50"] forState:UIControlStateNormal];
    _btnPrev.frame = CGRectMake(30, self.bounds.origin.y + 50.0f, 38.0f, 130.0f);
    [_btnPrev addTarget:self action:@selector(PrevImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btnPrev];
    
    _btnNext = [[UIButton alloc]init];
    [_btnNext setImage:[UIImage imageNamed:@"Forward Filled-50"] forState:UIControlStateNormal];
    _btnNext.frame = CGRectMake(self.bounds.size.width - 68, self.bounds.origin.y + 50.0f, 38.0f, 130.0f);
    [_btnNext addTarget:self action:@selector(NextImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btnNext];
    

    
    _slideshow.delegate = self;
    [_slideshow setDelay:1]; // Delay between transitions
    [_slideshow setTransitionDuration:1]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addImagesFromResources:imgs]; // Add images from resources
    [_slideshow setTag:1];
    selectedIndex = 0;

    
}

-(void)receiveOffers:(NSMutableArray*)offers{
    _Offers = offers;
    _offerIndex = 0;
    
}


-(void)getCurrentIndex{
   tv = (UITableView *) self.superview.superview;
    hola = [self.contentView viewWithTag:1];
    [hola NextNoNext];
    tv = (UITableView *) self.superview.superview;
    vc = (UITableViewController *) tv.dataSource;
    vc->index = hola.currentIndex;
  
    
}

-(IBAction)NextImg:(id)sender{
    Offer *hello = [[Offer alloc]init];
//    if (_offerIndex == [_Offers count]-1) {
//        _offerIndex = 0;
//    }
//    if (_offerIndex < [_Offers count]-1){
//        _offerIndex = _offerIndex +1;
//    }
    

    hola = [self.contentView viewWithTag:1];
    [hola next];
    tv = (UITableView *) self.superview.superview;
    vc = (UITableViewController *) tv.dataSource;
    vc->index = hola.currentIndex;
    hello = [_Offers objectAtIndex:(hola.currentIndex)];
    _lblPoints.text = hello.OfferPoints;
}

-(IBAction)PrevImg:(id)sender{
    Offer *hello = [[Offer alloc]init];
    hola = [self.contentView viewWithTag:1];
   [hola previous];
   tv = (UITableView *) self.superview.superview;
   vc = (UITableViewController *) tv.dataSource;
   vc->index = hola.currentIndex;
    hello = [_Offers objectAtIndex:(hola.currentIndex)];
    _lblPoints.text = hello.OfferPoints;
}

#pragma mark - KASlideShow delegate

- (void) kaSlideShowDidNext:(KASlideShow *)slideShow
{
    NSLog(@"kaSlideShowDidNext, index : %d",slideShow.currentIndex);
}

-(void)kaSlideShowDidPrevious:(KASlideShow *)slideShow
{
    NSLog(@"kaSlideShowDidPrevious, index : %d",slideShow.currentIndex);
}

#pragma mark - Button methods

- (IBAction)previous:(id)sender
{
    [_slideshow previous];
}

- (IBAction)next:(id)sender
{
    [_slideshow next];
}

- (IBAction)Like:(id)sender
{
    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
    OffersTableViewController *hola = [[OffersTableViewController alloc]init];
    [hola callLogIn];

}

- (IBAction)startStrop:(id)sender
{
    UIButton * button = (UIButton *) sender;
    
    if([button.titleLabel.text isEqualToString:@"Start"]){
        [_slideshow start];
        [button setTitle:@"Stop" forState:UIControlStateNormal];
    }else{
        [_slideshow stop];
        [button setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (IBAction)switchType:(id)sender
{
    UIButton * button = (UIButton *) sender;
    
    if([button.titleLabel.text isEqualToString:@"Fade"]){
        [_slideshow setTransitionType:KASlideShowTransitionFade];
        [button setTitle:@"Slide" forState:UIControlStateNormal];
    }else{
        [_slideshow setTransitionType:KASlideShowTransitionSlide];
        [button setTitle:@"Fade" forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

