//
//  OfferViewController.m
//  AppTest
//
//  Created by Rafael Perez on 9/19/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "OfferViewController.h"
#import "Offer.h"
#import "ViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"


@interface OfferViewController ()

@end

@implementation OfferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    Offer *offer = [[Offer alloc]init];
//    offer = self.Offer;
  self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoBixi2"]];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"atrás"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleBack:)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
  //  _imgOffer.image = [UIImage imageNamed:self.hola];
    
    
    
    
    [_imgOffer sd_setImageWithURL:[NSURL URLWithString:self.offer.OfferImage[0]]
                  placeholderImage:[UIImage imageNamed:@"Garage-50"]];
    _lblPoints.text = [NSString stringWithFormat:@"%@B",self.offer.OfferPoints ];
    
    _txtOfferName.text = self.offer.OfferName;
    [_lblOfferDescription setNumberOfLines:0];
    [_lblOfferDescription sizeToFit];
    _txtOfferDescription.text = self.offer.OfferDescription;
    
    
    _slideshow.delegate = self;
    [_slideshow setDelay:1]; // Delay between transitions
    [_slideshow setTransitionDuration:1]; // Transition duration
    [_slideshow setTransitionType:KASlideShowTransitionSlide]; // Choose a transition type (fade or slide)
    [_slideshow setImagesContentMode:UIViewContentModeScaleAspectFill]; // Choose a content mode for images to display
    [_slideshow addImagesFromResources:self.offer.OfferImage]; // Add images from resources
    [_slideshow setTag:1];
    if ([self.offer.OfferImage count]>1) {
        _btnPrev = [[UIButton alloc]init];
        [_btnPrev setImage:[UIImage imageNamed:@"Back Filled-50"] forState:UIControlStateNormal];
        _btnPrev.frame = CGRectMake(10, self.slideshow.bounds.size.height/2 - 90, 38.0f, 130.0f);
        [_btnPrev addTarget:self action:@selector(previous:) forControlEvents:UIControlEventTouchUpInside];
        [self.slideshow addSubview:_btnPrev];
        
        _btnNext = [[UIButton alloc]init];
        [_btnNext setImage:[UIImage imageNamed:@"Forward Filled-50"] forState:UIControlStateNormal];
        _btnNext.frame = CGRectMake(self.slideshow.bounds.size.width - 48, self.slideshow.bounds.size.height/2 - 90, 38.0f, 130.0f);
        [_btnNext addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        [self.slideshow addSubview:_btnNext];
    }
    _btnLike = [[UIButton alloc]init];
    [_btnLike setImage:[UIImage imageNamed:@"Like-50"] forState:UIControlStateNormal];
    _btnLike.frame = CGRectMake(self.slideshow.bounds.size.width - 68, self.slideshow.bounds.origin.y + 20.0f, 50.0f, 35.0f);
    //[_btnLike addTarget:self action:@selector(PrevImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.slideshow addSubview:_btnLike];
    
    _btnShare = [[UIButton alloc]init];
    [_btnShare setImage:[UIImage imageNamed:@"Subir"] forState:UIControlStateNormal];
    _btnShare.frame = CGRectMake(self.slideshow.bounds.size.width - 100.0f, self.slideshow.bounds.origin.y + 18.0f, 50.0f, 35.0f);
    //[_btnLike addTarget:self action:@selector(PrevImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.slideshow addSubview:_btnShare];
    //[_slideshow addSubView:_lblPoints];
    [_slideshow bringSubviewToFront:_lblPoints];
    
    

}

- (void)viewDidLayoutSubviews {
    [_txtOfferName setContentOffset:CGPointZero animated:YES];
    [_txtOfferDescription setContentOffset:CGPointZero animated:YES];
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
//    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
//    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
//    OffersTableViewController *hola = [[OffersTableViewController alloc]init];
//    [hola callLogIn];
    
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
   // [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"callReclaim"]) {
        ViewController *KeyboardViewController = [segue destinationViewController];
        //     [cell getCurrentIndex];
        KeyboardViewController.productID = _offer.OfferID;
        KeyboardViewController.Message = @"La oferta ha sido reclamada!";
        KeyboardViewController.Type = @"2";
        
    }
    
    
}

- (void)handleBack:(id)sender {
    // pop to root view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
