//
//  WNTNThirdTableVIewCell.m
//  WeatherNice
//
//  Created by 钟炽琴 on 15/12/14.
//  Copyright © 2015年 ZCQ. All rights reserved.
//

#import "WNTNThirdTableVIewCell.h"
#import <Masonry.h>
#import "WNCollectionViewCell.h"
#import "WNDaily_forecast.h"
#import <MJExtension.h>

///温度曲线的种类
typedef NS_ENUM(NSInteger, WNChartLineType) {
    
    WNChartLineTypeMax,//最高温度
    WNChartLineTypeMin,//最低温度

};

@interface WNChartLineView : UIView

@property (nonatomic, strong) NSArray * pathOnePoints;
@property (nonatomic, strong) NSArray * pathTwoPoints;
@property (nonatomic, strong, readonly) CAShapeLayer * layer1;
@property (nonatomic, strong, readonly) CAShapeLayer * layer2;


@end

@implementation WNChartLineView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)setPathOnePoints:(NSArray *)pathOnePoints
{
    _pathOnePoints = pathOnePoints;
    if (_layer1) {
        //如果存在需要移除
        [_layer1 removeFromSuperlayer];
        _layer1 = nil;
    }
#pragma mark ------ 创建第一条线
    UIBezierPath * path = [self graphPathFromPoints:pathOnePoints rect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2) range:[self getMaxRange:_pathOnePoints] type:WNChartLineTypeMax];
    //实例化layer
    _layer1 = [CAShapeLayer layer];
    //传入路径
    _layer1.path = path.CGPath;
    //设置线条的宽度
    _layer1.lineWidth = 2;
    //设置填充颜色
    _layer1.fillColor = [UIColor clearColor].CGColor;
    //设置线条的颜色
    _layer1.strokeColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:_layer1];
}

- (void)setPathTwoPoints:(NSArray *)pathTwoPoints
{
    _pathOnePoints = pathTwoPoints;
    if (_layer2) {
        [_layer2 removeFromSuperlayer];
        _layer2 = nil;
    }
    #pragma mark ------ 创建第二条线
    UIBezierPath * path = [self graphPathFromPoints:pathTwoPoints rect:CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2) range:[self getMaxRange:_pathOnePoints] type:WNChartLineTypeMin];
    _layer2 = [CAShapeLayer layer];
    _layer2.path = path.CGPath;
    _layer2.lineWidth = 2;
    _layer2.fillColor = [UIColor clearColor].CGColor;
    _layer2.strokeColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:_layer2];
}

- (CGFloat)getMaxRange:(NSArray *)array
{
    //找到NSArray的最大值
    NSNumber* max1=[array valueForKeyPath:@"@max.floatValue"];
    return  (self.frame.size.height/2)/(max1.integerValue);
}
- (CGFloat)getMinRange:(NSArray *)array
{
    //找到NSArray的最小值
    NSNumber* min1=[array valueForKeyPath:@"@min.floatValue"];
    return  (self.frame.size.height/2)/(min1.integerValue);
}

#pragma mark ----- 计算坐标
- (CGPoint)shadowViewPointAtIndex:(NSInteger)index points:(NSArray *)points frame:(CGRect)rect range:(CGFloat)range{
    
    CGFloat space = (rect.size.width)/(points.count);
    
    return CGPointMake(space *(index) + space/2, (rect.size.height - [points[index] floatValue] * range) + rect.origin.y);
    
}

#pragma mark ----- 获取bezierPath
- (UIBezierPath *)graphPathFromPoints:(NSArray *)points rect:(CGRect)rect range:(CGFloat)range type:(WNChartLineType)type{
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    for (NSInteger i=0;i<points.count;i++) {
        CGPoint point=[self shadowViewPointAtIndex:i points:points frame:rect range:range];
        [self creatView:point];
        NSString * str;
        switch (type) {
            case WNChartLineTypeMax:{
                str = [NSString stringWithFormat:@"%@°",points[i]];
                [self creatLabel:CGPointMake(point.x, point.y - 15) withIndex:i withText:str];
            }
                break;
            case WNChartLineTypeMin:
            {
                str = [NSString stringWithFormat:@"-%@°",points[i]];
                [self creatLabel:CGPointMake(point.x, point.y + 15) withIndex:i withText:str];
            }
                break;
            default:
                break;
        }
        
        if(i==0)
            //添加起点
            [path moveToPoint:point];
        //添加其他的点
        [path addLineToPoint:point];
        
    }
    return path;
}

//lable 显示温度
- (void)creatLabel:(CGPoint)point withIndex:(NSInteger)index withText:(NSString *)text
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    label.text = text;
    label.center = point;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

//创建点
- (void)creatView:(CGPoint)point;
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    view.center = point;
    //创建圆角
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.frame.size.width/2];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    [view.layer addSublayer:layer];
    [self addSubview:view];
}

@end

@interface WNTNThirdTableVIewCell ()

@property (nonatomic, strong) WNChartLineView * bgView;

@end
@implementation WNTNThirdTableVIewCell
{
    NSMutableDictionary *_dict;
    UICollectionView *collctionView;
    NSMutableArray *_maxArray;  //最高温度的数据源
    NSMutableArray *_minArray;   //最低温度的数据源
}
- (void)awakeFromNib {
    
    // Initialization code
    [self creatCollectionView];
    [self creatView];

    
}

- (void)creatView
{
    _bgView = [[WNChartLineView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth + WScreenWidth/6, 80)];
    _bgView.center = CGPointMake((WScreenWidth + WScreenWidth/6)/2, self.center.y);
    //_bgView.backgroundColor = [UIColor redColor];
    _bgView.userInteractionEnabled = NO;
    [collctionView addSubview:_bgView];
    
}

- (void)creatCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    collctionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, self.contentView.frame.size.height) collectionViewLayout:flowLayout];
    collctionView.backgroundColor =[UIColor clearColor];
    collctionView.delegate = self;
    collctionView.dataSource = self;
    [self.contentView addSubview:collctionView];
    UINib *nib  =[UINib nibWithNibName:@"WNCollectionViewCell" bundle:[NSBundle mainBundle]];
    [collctionView registerNib:nib forCellWithReuseIdentifier:@"abc"];
}


// 设置cell的宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.contentView.frame.size.width/6, self.contentView.frame.size.height);

}

// 每组多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *daily_forecast = [WNDaily_forecast objectArrayWithKeyValuesArray:_dict[@"daily_forecast"]];
    WNDaily_forecast *model = daily_forecast[indexPath.row];
    WNCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"abc" forIndexPath:indexPath];
    cell.dateLable.text = @"fdasf";
    [cell creatCollectionViewCellWithModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
       NSLog(@"点了第%ld组, 第几%ld个cell", indexPath.section, indexPath.row);

}

- (void)creatThirdCellWithDict:(NSDictionary *)dict
{
    _dict = [[NSMutableDictionary alloc]init];
    _dict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [self tempArray];
    [collctionView reloadData];
}

- (void)tempArray
{
    _maxArray = [[NSMutableArray alloc]init];
    _minArray = [[NSMutableArray alloc]init];
    NSArray *daily_forecast = [WNDaily_forecast objectArrayWithKeyValuesArray:_dict[@"daily_forecast"]];
    for (WNDaily_forecast *model in daily_forecast) {
        NSInteger max = [model.tmp[@"max"] integerValue];
        [_maxArray addObject:@(max)];
        NSInteger min = labs([model.tmp[@"min"] integerValue]);
        [_minArray addObject:@(min)];
    }
//    NSLog(@"min%@",_minArray);
//    NSLog(@"max%@",_maxArray);
    if (_maxArray.count > 0) {
        _bgView.pathOnePoints = _maxArray;
        _bgView.pathTwoPoints = _minArray;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
