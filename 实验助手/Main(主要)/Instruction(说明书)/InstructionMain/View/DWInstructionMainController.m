//
//  DWInstructionMainController.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQColor.h"
#import "SXQExpCategory.h"
#import "SXQInstructionListController.h"
#import "SXQInstructionServiceImpl.h"
#import "DWInstructionMainController.h"
#import "DWInstructionCell.h"
#import "DWInstructionMainHeader.h"

@interface DWInstructionMainController ()
@property (nonatomic,strong) id<SXQInstructionService> service;
@end

@implementation DWInstructionMainController
static NSString * const reuseIdentifier = @"Cell";
- (NSArray *)expCategories
{
    if (!_expCategories) {
        _expCategories = @[];
    }
    return _expCategories;
}
- (id<SXQInstructionService>)service
{
    if (!_service) {
        _service = [[SXQInstructionServiceImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupCollecitonView];
    [self p_loadData];
}
#pragma mark - 设置collectionview
- (void)p_setupCollecitonView
{
    self.collectionView.backgroundColor = RGB(226, 226, 226);
    self.title = @"说明书";
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DWInstructionCell class])];
}
#pragma mark - 加载数据
- (void)p_loadData
{
    @weakify(self)
    [[self.service instructionCategorySignal]
     subscribeNext:^(NSArray *resultArray){
         @strongify(self)
         self.expCategories = resultArray;
         [self.collectionView reloadData];
    }
     error:^(NSError *error) {
         
     }];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SXQExpCategory *expcategory = self.expCategories[indexPath.section];
    SXQInstructionListController *listVC = [SXQInstructionListController new];
    listVC.categoryItem = expcategory.expSubCategories[indexPath.row];
    [self.navigationController pushViewController:listVC animated:YES];
}
@end
