//
//  LikedOffersCollectionViewController.h
//  AppTest
//
//  Created by Rafael Perez on 3/25/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface LikedOffersCollectionViewController : UICollectionViewController
@property (strong, nonatomic) NSMutableArray *offersArray;
@property (weak, nonatomic) Offer *offerSelected;
@property (weak, nonatomic) Offer *offerClicked;
@property (weak, nonatomic) IBOutlet UIButton *dislike;
@end
