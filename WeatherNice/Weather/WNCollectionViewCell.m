//
//  WNCollectionViewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/14.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNCollectionViewCell.h"
#import <MJExtension.h>
#import "WNDaily_forecast.h"
#import <Masonry.h>

@implementation WNCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    _view.layer.borderWidth = 0.5;
    _view.layer.borderColor = [UIColor whiteColor].CGColor;
    _view.backgroundColor = [UIColor clearColor];
 
}

- (void)creatCollectionViewCellWithModel:(WNDaily_forecast *)model
{
    _dateLable.text = [NSString stringWithFormat:@"%@\n%@",model.wind[@"dir"],model.wind[@"sc"]];
    NSArray *array = [model.date componentsSeparatedByString:@"-"];
    _weekLable.text = [NSString stringWithFormat:@"%@/%@",array[1],array[2]];
    _code_dImage.image = [[UIImage imageNamed:model.cond[@"code_d"]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _code_nImage.image = [[UIImage imageNamed:model.cond[@"code_n"]]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _txt_dLable.text = model.cond[@"txt_d"];
    _txt_nLable.text = model.cond[@"txt_n"];

}
@end
