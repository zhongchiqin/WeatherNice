//
//  WNTNThirdTableVIewCell.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/14.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNTNThirdTableVIewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

- (void)creatThirdCellWithDict:(NSDictionary *)dict;

@end
