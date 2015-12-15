//
//  WNCollectionViewCell.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/14.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNDaily_forecast.h"

@interface WNCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *weekLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *txt_dLable;
@property (weak, nonatomic) IBOutlet UILabel *txt_nLable;
@property (weak, nonatomic) IBOutlet UIImageView *code_nImage;
@property (weak, nonatomic) IBOutlet UIImageView *code_dImage;

- (void)creatCollectionViewCellWithModel:(WNDaily_forecast *) model;
@end
