//
//  FavoritesCollectionViewCell.h
//  AppTest
//
//  Created by Rafael Perez on 3/25/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblOfferName;
@property (weak, nonatomic) IBOutlet UILabel *lblOfferPoints;
@property (weak, nonatomic) IBOutlet UIButton *btnDislike;
@property (weak, nonatomic) IBOutlet UIImageView *ivOfferImage;
@end
