# HZWaterflowLayout
一个简单易用的瀑布流小例子
## 设置列数
- (CGFloat)columnCountInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
return 3;
}
## 设置cell的高度 
-(CGFloat)waterflowLayout:(HZWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
return (100 + arc4random_uniform(100));
}
## 设置cell的行间距 
- (CGFloat)rowMarginInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
return 10;
}
## 设置cell的列间距 
- (CGFloat)columnMarginInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
return 10;
}
## 设置cell的内边距 
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
return UIEdgeInsetsMake(20, 10, 10, 10);
}

