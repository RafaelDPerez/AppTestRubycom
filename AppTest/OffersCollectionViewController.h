//
//  OffersCollectionViewController.h
//  AppTest
//
//  Created by Rafael Perez on 9/15/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface OffersCollectionViewController : UICollectionViewController
@property (weak, nonatomic) Offer *selectedOffer;
@end
