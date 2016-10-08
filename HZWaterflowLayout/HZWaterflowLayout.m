//
//  HZWaterflowLayout.m
//  瀑布流-01
//
//  Created by 韩转 on 15/6/7.
//  Copyright © 2015年 韩转. All rights reserved.
//

#import "HZWaterflowLayout.h"
/** 默认列数 */
static const CGFloat HZDefaultColumCount = 3;
/** 每一列之间的间距 */
static const CGFloat HZDefaultColumMargin = 10;
/** 每一行之间的间距 */
static const CGFloat HZDefaultRowMargin = 10;
/** 边缘间距 */
static const UIEdgeInsets HZDefaultEdgeInsetsMargin = {20,10,10,10};

@interface HZWaterflowLayout()
/** 存放所有cell的布局属性 */
@property (nonatomic,strong)NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic,assign)CGFloat contentHeight;


/** 行间距 */
- (CGFloat)rowMargin;
/** 列间距 */
- (CGFloat)columnMargin;
/** 列数 */
- (CGFloat)columCount;
/** 内边距 */
- (UIEdgeInsets)edgeInsets;


@end
@implementation HZWaterflowLayout
#pragma mark -代理方法处理
/** 行间距 */
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterflowLayout:)])
    {
        return  [self.delegate rowMarginInWaterflowLayout:self];
    }
    else
    {
       return  HZDefaultRowMargin;
        
    }
}
/** 列间距 */
- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterflowLayout:)])
    {
        return  [self.delegate columnMarginInWaterflowLayout:self];
    }
    else
    {
        return  HZDefaultColumMargin;
        
    }
}
/** 列数 */
- (CGFloat)columCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterflowLayout:)])
    {
        return  [self.delegate columnCountInWaterflowLayout:self];
    }
    else
    {
        return  HZDefaultColumCount;
        
    }
}
/** 内边距 */
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterflowLayout:)])
    {
        return  [self.delegate edgeInsetsInWaterflowLayout:self];
    }
    else
    {
        return  HZDefaultEdgeInsetsMargin;
        
    }
}

#pragma mark -懒加载
//懒加载
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights)
    {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
//懒加载
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray)
    {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

/** 初始化 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.contentHeight = 0;
    //清楚以前所有计算出的高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columCount; i ++)
    {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    //清空之前所有的属性
    [self.attrsArray removeAllObjects];
    
    //开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0 ; i < count; i ++)
    {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath对应的cell属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }

}
/** 决定cell的排布 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
/** 返回indexPath位置对应的布局属性 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectionview的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //设置frame
    
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columCount - 1) * self.columnMargin) / self.columCount;
    
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWidth:w];
    
    // w  h
    //Sw  Sh
    //找出高度最短的那一列
//    __block NSInteger destColumn = 0;
//    __block CGFloat minColumnHeight = MAXFLOAT;
//    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *columnHeightNumber, NSUInteger idx, BOOL * _Nonnull stop)
//    {
//        CGFloat columnHeight = columnHeightNumber.doubleValue;
//        if (minColumnHeight > columnHeight)
//        {
//            minColumnHeight = columnHeight;
//            destColumn = idx;
//        }
//    }];
    
     NSInteger destColumn = 0;
     CGFloat minColumnHeight = [self.columnHeights[0]doubleValue];
    for (int i = 1; i < self.columCount; i ++)
    {
        //取得第i列的高度
        CGFloat columnHeight = [self.columnHeights [i]doubleValue];
        
        if (minColumnHeight > columnHeight)
        {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }

    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y  = minColumnHeight;
    
    if (y != self.edgeInsets.top)
    {
        y += self.rowMargin;
    }

    attrs.frame = CGRectMake(x, y, w, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    //记录内容的高度
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < columnHeight)
    {
        self.contentHeight = columnHeight;
    }

    return attrs;
}

- (CGSize)collectionViewContentSize
{
//    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
//    for (NSInteger i = 1; i < self.columCount; i++) {
//        // 取得第i列的高度
//        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
//        
//        if (maxColumnHeight < columnHeight) {
//            maxColumnHeight = columnHeight;
//        }
//    }
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}
@end
