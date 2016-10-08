//
//  ViewController.m
//  WaterFlowLayoutExample
//
//  Created by 韩转 on 16/10/8.
//  Copyright © 2016年 韩转. All rights reserved.
//

#import "ViewController.h"
#import "HZWaterflowLayout.h"
@interface ViewController ()<UICollectionViewDataSource,HZWaterflowLayoutDelegate>

@end
static NSString *HZWaterId = @"water";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //布局
    [self setupLayout];
    
}
/** 布局 */
- (void)setupLayout
{
    // 创建布局
    HZWaterflowLayout *layout = [[HZWaterflowLayout alloc] init];
    layout.delegate = self;
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    // 注册
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HZWaterId];
    
    [self.view addSubview:collectionView];
    //    self.collectionView = collectionView;
    
}
#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HZWaterId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
#pragma mark -HZWaterflowLayoutDelegate
/** 计算cell的高度 */
-(CGFloat)waterflowLayout:(HZWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    return (100 + arc4random_uniform(100));
}
/** 设置cell的行间距 */
- (CGFloat)rowMarginInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
    return 10;
}
/** 设置cell的列间距 */
- (CGFloat)columnMarginInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
    return 10;
}
/** 设置cell的内边距 */
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(20, 10, 10, 10);
}
/** 设置cell的列数 */
- (CGFloat)columnCountInWaterflowLayout:(HZWaterflowLayout *)waterflowLayout
{
    return 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
