//
//  WNSuggestionCollectionViewCell.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/15.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNSuggestion.h"
@interface WNSuggestionCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *suggestionImage;
@property (weak, nonatomic) IBOutlet UILabel *brfLable;
@property (weak, nonatomic) IBOutlet UILabel *txtLable;

- (void)creatCellWithModel:(WNSuggestion *)model;

@end
