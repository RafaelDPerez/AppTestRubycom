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
    _btnPrev = [(UIButton*) self.contentView viewWithTag:5];
    _btnNext = [(UIButton*) self.contentView viewWithTag:10];
    _btnLike = [(UIButton*) self.contentView viewWithTag:100];
    
    [self.contentView addSubview:_btnNext];
    [self.contentView bringSubviewToFront:_btnNext];
    [self.contentView addSubview:_btnPrev];
    [self.contentView bringSubviewToFront:_btnPrev];
    [self.contentView addSubview:_btnLike];
    [self.contentView bringSubviewToFront:_btnLike];
    _slideshow.delegate = self;
    [_slideshow setDelay:1]; // Delay between transitions
    [_slideshow setTransitionDuration:1]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addImagesFromResources:imgs]; // Add images from resources
    [_slideshow setTag:1];
    selectedIndex = 0;

    
}

-(NSUInteger*)getCurrentIndex{

    return selectedIndex;
}

-(IBAction)NextImg:(id)sender{
    //KASlideShow *hola = [self.contentView viewWithTag:1];
    hola = [self.contentView viewWithTag:1];
    [hola next];
     //[[self.contentView viewWithTag:1] next];
   // OffersTableViewController *index = self.contentView.superview;
    tv = (UITableView *) self.superview.superview;
  vc = (UITableViewController *) tv.dataSource;
    vc->index = hola.currentIndex;
  //  selectedIndex = hola.currentIndex;
    
    
}

-(IBAction)PrevImg:(id)sender{
    
    //[[self.contentView viewWithTag:1] previous];
    hola = [self.contentView viewWithTag:1];
    [hola previous];
    //[[self.contentView viewWithTag:1] next];
    // OffersTableViewController *index = self.contentView.superview;
   tv = (UITableView *) self.superview.superview;
    vc = (UITableViewController *) tv.dataSource;
    vc->index = hola.currentIndex;
    
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

