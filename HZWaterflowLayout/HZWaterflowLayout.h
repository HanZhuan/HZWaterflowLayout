//
//  HZWaterflowLayout.h
//  瀑布流-01
//
//  Created by 韩转 on 15/6/7.
//  Copyright © 2015年 韩转. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZWaterflowLayout;

@protocol HZWaterflowLayoutDelegate <NSObject>

@required
/** 返回cell的高度 */
- (CGFloat)waterflowLayout:(HZWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
/** 设置列数 */
- (CGFloat)columnCountInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout;
/** 设置cell的列间距 */
- (CGFloat)columnMarginInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout;
/** 设置cell的行间距 */
- (CGFloat)rowMarginInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout;
/** 设置cell的内边距 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout;
@end

@interface HZWaterflowLayout : UICollectionViewLayout

/** 代理 */
@property (nonatomic,weak)id<HZWaterflowLayoutDelegate> delegate;



@end
