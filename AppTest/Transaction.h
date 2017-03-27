//
//  Transaction.h
//  AppTest
//
//  Created by Rafael Perez on 3/26/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject
@property (strong,nonatomic) NSString *TransactionDate;
@property (strong,nonatomic) NSString *TransactionDescription;
@property (strong,nonatomic) NSString *TransactionCommerce;
@property (strong,nonatomic) NSString *TransactionPoints;
@property (strong,nonatomic) NSString *TransactionType;
@end
