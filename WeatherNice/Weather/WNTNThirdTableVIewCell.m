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

static NSString * const Identifier = @"Identifier";
///温度曲线的种类
typedef NS_ENUM(NSInteger, WNChartLineType) {
    
    WNChartLineTypeMax,//最高温度
    WNChartLineTypeMin,//最低温度

};

@interface WNChartLineView : UIView
/**
 *
 */
@property (nonatomic, strong) NSArray * pathOnePoints;
/**
 *
 */
@property (nonatomic, strong) NSArray * pathTwoPoints;
/**
 *
 */
@property (nonatomic, strong, readonly) CAShapeLayer * layer1;
/**
 *
 */
@property (nonatomic, strong, readonly) CAShapeLayer * layer2;
/**
 *  移除线和label
 */
@property (nonatomic, assign) BOOL removeLine;

@end

@implementation WNChartLineView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}
- (void)setRemoveLine:(BOOL)removeLine
{
    _removeLine = removeLine;
    if (removeLine) {
        [_layer1 removeFromSuperlayer];
        _layer1 = nil;
        [_layer2 removeFromSuperlayer];
        _layer2 = nil;
        
//        删除所有子视图（lable、点）
        NSArray * subViews = self.subviews;
        for (UIView * view in subViews) {
            [view removeFromSuperview];
            
           // [self addSubview:view];
        }
    }
}
#pragma mark ------ 创建第一条线
- (void)setPathOnePoints:(NSArray *)pathOnePoints
{
    _pathOnePoints = pathOnePoints;
    if (_layer1) {
        //如果存在需要移除
        [_layer1 removeFromSuperlayer];
        _layer1 = nil;
    }
    NSArray * newArray = [self getNewArray:pathOnePoints];
    UIBezierPath * path = [self graphPathFromPoints:newArray rect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2 - 10) range:[self getMaxRange:newArray] type:WNChartLineTypeMax];
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
#pragma mark ----------- 创建第二条线
- (void)setPathTwoPoints:(NSArray *)pathTwoPoints
{
    _pathTwoPoints = pathTwoPoints;
    if (_layer2) {
        [_layer2 removeFromSuperlayer];
        _layer2 = nil;
    }
    UIBezierPath * path = [self graphPathFromPoints:[self getNewArray:pathTwoPoints] rect:CGRectMake(0, self.frame.size.height/2 + 10, self.frame.size.width, self.frame.size.height/2 -10) range:[self getMaxRange:_pathOnePoints] type:WNChartLineTypeMin];
    _layer2 = [CAShapeLayer layer];
    _layer2.path = path.CGPath;
    _layer2.lineWidth = 2;
    _layer2.fillColor = [UIColor clearColor].CGColor;
    _layer2.strokeColor = [UIColor whiteColor].CGColor;
    
    [self.layer addSublayer:_layer2];
}

- (CGFloat)getMaxRange:(NSArray *)array
{
    //找到NSArray的最大、小值
    NSNumber* max1=[array valueForKeyPath:@"@max.floatValue"];
    NSNumber* min1=[array valueForKeyPath:@"@min.floatValue"];
    return labs(max1.integerValue - min1.integerValue);
}
- (NSArray *)getNewArray:(NSArray *)array
{
    NSNumber* min1=[array valueForKeyPath:@"@min.floatValue"];
    if(min1.integerValue < 0){
        NSInteger k = 0;
        NSMutableArray * array1 = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < array.count; i++) {
            NSNumber * number = array[i];
            k = number.integerValue +  labs(min1.integerValue);
            [array1 addObject:[NSNumber numberWithInteger:k]];
        }
        NSLog(@"数组存在负数%@",array1);
        return [array1 copy];
    }else{
        NSInteger k = 0;
        NSMutableArray * array1 = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < array.count; i++) {
            NSNumber * number = array[i];
            k = number.integerValue -  labs(min1.integerValue);
            [array1 addObject:[NSNumber numberWithInteger:k]];
        }
        NSLog(@"数组不存在负数%@",array1);
        return [array1 copy];
    }
}


#pragma mark ----- 计算坐标
- (CGPoint)shadowViewPointAtIndex:(NSInteger)index points:(NSArray *)points frame:(CGRect)rect range:(CGFloat)range type:(WNChartLineType)type{

    CGFloat space = (rect.size.width)/(points.count);
    if (type == WNChartLineTypeMax) {
        CGFloat hSpace = rect.size.height / range;
        CGPoint point = CGPointMake(space *(index) + space/2, rect.size.height - hSpace * [points[index] integerValue]);
        return point;
    }else{
        CGFloat hSpace = rect.size.height / range;
        
        CGPoint point = CGPointMake(space *(index) + space/2, rect.size.height - hSpace * [points[index] integerValue] + rect.origin.y);
        return point;
    }
}

#pragma mark ----- 获取bezierPath
- (UIBezierPath *)graphPathFromPoints:(NSArray *)points rect:(CGRect)rect range:(CGFloat)range type:(WNChartLineType)type{
    UIBezierPath *path=[UIBezierPath bezierPath];
    for (NSInteger i=0;i<points.count;i++) {
        CGPoint point=[self shadowViewPointAtIndex:i points:points frame:rect range:range type:type];
        [self creatView:point];
        NSString * str;
        switch (type) {
            case WNChartLineTypeMax:{
                str = [NSString stringWithFormat:@"%@°",
                       self.pathOnePoints[i]];
                [self creatLabel:CGPointMake(point.x, point.y - 15) withIndex:i withText:str];
            }
                break;
            case WNChartLineTypeMin:
            {
                str = [NSString stringWithFormat:@"%@°",
                       self.pathTwoPoints[i]];
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
    label.textColor = [UIColor whiteColor];
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
  //  _bgView.backgroundColor = [UIColor redColor];
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
    [collctionView registerNib:nib forCellWithReuseIdentifier:Identifier];
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
    WNCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
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
        NSInteger min = [model.tmp[@"min"] integerValue];
        [_minArray addObject:@(min)];
    }
    NSLog(@"min%@",_minArray);
    NSLog(@"max%@",_maxArray);
    if (_bgView) {
       
        if (_maxArray.count > 0) {
            _bgView.removeLine = YES;
            _bgView.pathOnePoints = _maxArray;
            _bgView.pathTwoPoints = _minArray;
        }else {
            _bgView.removeLine = YES;
        }
    }
}

@end
