//
//  WNSuggestionCollectionViewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/15.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNSuggestionCollectionViewCell.h"

@implementation WNSuggestionCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _backView.backgroundColor = [UIColor clearColor];
    _backView.layer.borderWidth = 0.5;
    _backView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
}
- (void)creatCellWithModel:(WNSuggestion *)model
{


}
@end
