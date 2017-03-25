//
//  Offer.h
//  AppTest
//
//  Created by Rafael Perez on 9/19/16.
//  Copyright © 2016 Rafael Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Offer : NSObject
@property (strong,nonatomic) NSString *OfferExpirationDate;
@property (strong,nonatomic) NSString *OfferDescription;
@property (strong,nonatomic) NSArray *OfferImage;
@property (strong,nonatomic) NSString *IsOffer;
@property (strong,nonatomic) NSString *OfferName;
@property (strong,nonatomic) NSString *OfferPoints;
@property (strong,nonatomic) NSString *OfferID;
@property (strong,nonatomic) NSString *OfferQuantity;
@property (strong,nonatomic) NSString *OfferStatus;
@end
