//
//  SXQReviewDetailController.m
//  实验助手
//
//  Created by sxq on 15/11/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQReview.h"
#import "SXQReviewDetailController.h"
#import "SXQReviewDetail.h"
#import "ArrayDataSource+TableView.h"
#import "DWGroup.h"
#import "SXQReviewItem.h"
#import "SXQReviewCell.h"
#define ReviewCellIdentifier @"Review Cell"
@interface SXQReviewDetailController ()
@property (nonatomic,strong) SXQReview *review;
@property (nonatomic,strong) id<SXQInstructionService> service;
@property (nonatomic,strong) ArrayDataSource *arraryDataSource;
@property (nonatomic,strong) NSMutableArray *groups;
@end
@implementation SXQReviewDetailController
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (instancetype)initWithReview:(SXQReview *)review service:(id<SXQInstructionService>)service
{
    self = [super init];
    if (self) {
        _review = review;
        _service = service;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_loadReviewDetailData];
}
- (void)p_setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:@"SXQReviewCell" bundle:nil] forCellReuseIdentifier:ReviewCellIdentifier];
    _arraryDataSource = [[ArrayDataSource alloc] initWithGroups:self.groups];
    self.tableView.dataSource = _arraryDataSource;
}
- (void)p_loadReviewDetailData
{
    @weakify(self)
    [[[[self.service getService] reviewDetailSignalWithReview:self.review]
     map:^id(SXQReviewDetail *reviewDetail) {
         return [self groupWithReviewDetail:reviewDetail];
     }]
    subscribeNext:^(DWGroup *group) {
        @strongify(self)
        [self.groups insertObject:group atIndex:0];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}
- (DWGroup *)groupWithReviewDetail:(SXQReviewDetail *)reviewDetail
{
    DWGroup *group = [[DWGroup alloc] initWithWithHeader:reviewDetail.reviewInfo footer:nil items:reviewDetail.reviewOpts];
    group.identifier = ReviewCellIdentifier;
    group.configureBlk = ^(SXQReviewCell *cell,SXQReviewItem *item)
    {
        cell.textLabel.text = item.expReviewOptName;
        cell.detailTextLabel.text = item.reviewOptScore;
    };
    return group;
}
@end
