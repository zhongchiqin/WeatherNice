//
//  WNCitySearchTableViewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/17.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNCitySearchTableViewCell.h"

@implementation WNCitySearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatButton];
    }
    return self;
}

-(void)creatButton
{
//    for (int i = 0; i < 5; i++) {
//        for (int i = 0; i < 3; i++) {
//            UIButton *button = [UIButton alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//        }
//    }
//
//
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end