//
//  Commerce.h
//  AppTest
//
//  Created by Rafael Perez on 3/6/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commerce : NSObject
@property (strong,nonatomic) NSString *CommerceAddress;
@property (strong,nonatomic) NSString *CommerceID;
@property (strong,nonatomic) NSString *CommerceLat;
@property (strong,nonatomic) NSString *CommerceLng;
@property (strong,nonatomic) NSString *CommerceName;
@property (strong,nonatomic) NSString *CommerceImage;
@property (strong,nonatomic) NSMutableArray *CommerceOffers;
@property (strong,nonatomic) NSMutableArray *CommerceOffersImages;
@end
