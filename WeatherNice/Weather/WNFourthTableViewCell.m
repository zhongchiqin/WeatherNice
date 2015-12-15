//
//  WNFourthTableViewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/15.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNFourthTableViewCell.h"
#import "WNSuggestionCollectionViewCell.h"
#import "WNSuggestion.h"
#import  <MJExtension.h>
static NSString * const Identifier = @"Identifier";

@implementation WNFourthTableViewCell
{
    UICollectionView *collectionView;
    NSMutableDictionary *_dict;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatCell];
    }
    return self;
}
- (void)creatCell
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
   
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, 320) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
//    collectionView.backgroundColor = [UIColor yellowColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    UINib *nib = [UINib nibWithNibName:@"WNSuggestionCollectionViewCell" bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:Identifier];
    [self.contentView addSubview:collectionView];
    
}

// 设置cell的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WScreenWidth/2,self.contentView.frame.size.height/4);

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WNSuggestion *suggestion = [WNSuggestion objectWithKeyValues:_dict[@"suggestion"]];
    WNSuggestionCollectionViewCell *suggestionCell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    suggestionCell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        suggestionCell.suggestionImage.image = [UIImage imageNamed:@"0"];
        suggestionCell.brfLable.text = @"舒适度指数";
        suggestionCell.txtLable.text = suggestion.comf[@"brf"];
    }else if (indexPath.row == 1){
        suggestionCell.suggestionImage.image = [UIImage imageNamed:@"info_9"];
        suggestionCell.brfLable.text = @"洗车指数";
        suggestionCell.txtLable.text = suggestion.cw[@"brf"];
    }else if (indexPath.row == 2){
        suggestionCell.suggestionImage.image = [UIImage imageNamed:@"info_11"];
        suggestionCell.brfLable.text = @"穿衣指数";
        suggestionCell.txtLable.text = suggestion.drsg[@"brf"];
    }else if (indexPath.row == 3){
        suggestionCell.suggestionImage.image = [UIImage imageNamed:@"0"];
        suggestionCell.brfLable.text = @"感冒指数";
        suggestionCell.txtLable.text = suggestion.flu[@"brf"];
    }else if (indexPath.row == 4){
        suggestionCell.suggestionImage.image = [UIImage imageNamed:@"info_17"];
        suggestionCell.brfLable.text = @"运动指数";
        suggestionCell.txtLable.text = suggestion.sport[@"brf"];
    }else if (indexPath.row == 5){
        suggestionCell.suggestionImage.image = [UIImage imageNamed:@"0"];
        suggestionCell.brfLable.text = @"旅游指数";
        suggestionCell.txtLable.text = suggestion.trav[@"brf"];
    }else if (indexPath.row == 6){
        suggestionCell.suggestionImage.image = [UIImage imageNamed:@"info_12"];
        suggestionCell.brfLable.text = @"紫外线指数";
        suggestionCell.txtLable.text = suggestion.uv[@"brf"];
    }
    return suggestionCell
    ;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点了第%ld组, 第几%ld个cell", indexPath.section, indexPath.row);
    

}
- (void)creatFourthCellWithDict:(NSDictionary *)dict
{
    _dict = [[NSMutableDictionary alloc]init];
    _dict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [collectionView reloadData];
}
- (void)awakeFromNib {
    // Initialization code
//    [self creatCell];
}                                                                                                            //


@end
