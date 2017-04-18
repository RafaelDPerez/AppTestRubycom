//
//  OfferViewController.h
//  AppTest
//
//  Created by Rafael Perez on 9/19/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "ViewController.h"
#import "Offer.h"
#import "KASlideShow.h"

@interface OfferViewController : ViewController
@property(weak, nonatomic) Offer *offer;
@property(weak, nonatomic) NSString *hola;
@property (weak, nonatomic) IBOutlet KASlideShow *slideshow;
@property (weak, nonatomic) IBOutlet UILabel *lblPoints;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferName;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferDescription;
@property (weak, nonatomic) IBOutlet UITextView *txtOfferDescription;
@property (weak, nonatomic) IBOutlet UITextView *txtOfferName;
@property (weak, nonatomic) IBOutlet UIImageView *imgOffer;
@property (strong,nonatomic) UIButton * btnPrev;
@property (strong,nonatomic) UIButton * btnNext;
@property (strong,nonatomic) UIButton * btnLike;
@property (strong,nonatomic) UIButton * btnShare;
@end
