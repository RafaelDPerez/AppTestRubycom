//
//  OfferViewController.h
//  AppTest
//
//  Created by Rafael Perez on 9/19/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import "ViewController.h"
#import "Offer.h"

@interface OfferViewController : ViewController
@property(weak, nonatomic) Offer *Offer;
@property(weak, nonatomic) NSString *hola;
@property (weak, nonatomic) IBOutlet UILabel *lblPoints;
@property (weak, nonatomic) IBOutlet UILabel *lblPoints;
@property (weak, nonatomic) IBOutlet UILabel *lblPoints;
@property (weak, nonatomic) IBOutlet UIImageView *imgOffer;
@end
