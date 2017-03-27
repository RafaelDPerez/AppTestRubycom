//
//  TransactionsTableViewCell.h
//  AppTest
//
//  Created by Rafael Perez on 3/26/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblOfferName;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferPoints;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferdate;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferDescription;
@end
