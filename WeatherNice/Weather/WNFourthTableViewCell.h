//
//  WNFourthTableViewCell.h
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/15.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNFourthTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

- (void)creatFourthCellWithDict:(NSDictionary *)dict;

@end
