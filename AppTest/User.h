//
//  User.h
//  AppTest
//
//  Created by Rafael Perez on 1/17/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (weak,nonatomic) NSString *firstName;
@property (weak,nonatomic) NSString *lastName;
@property (weak,nonatomic) NSString *documentId;
@property (weak,nonatomic) NSString *phone1;
@property (weak,nonatomic) NSString *phone2;
@property (weak,nonatomic) NSString *address;
@property (weak,nonatomic) NSString *gender;
@property (weak,nonatomic) NSString *email;
@property (weak,nonatomic) NSString *birthDate;
@property (weak,nonatomic) NSString *age;
@property (weak,nonatomic) NSString *image;
@property (weak,nonatomic) NSString *password;
@property (weak,nonatomic) NSString *passwordConfirm;




@end
