//
//  DWReviewTableController.m
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "ArrayDataSource+TableView.h"
#import "DWReviewTableController.h"
#import "SXQCommentCell.h"
#import "SXQReview.h"
@interface DWReviewTableController ()
@property (nonatomic,strong) ArrayDataSource *reviewDataSource;
@end

@implementation DWReviewTableController
- (instancetype)initWithReviews:(NSArray *)reviews
{
    if (self = [super init]) {
        _reviewDataSource = [[ArrayDataSource alloc] initWithItems:reviews
                                                    cellIdentifier:NSStringFromClass([SXQCommentCell class])
                                                cellConfigureBlock:^(SXQCommentCell *cell, SXQReview *review) {
                                                                    cell.review = review; }];
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
}
- (void)p_setupTableView
{
    self.title = @"评论";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXQCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SXQCommentCell class])];
    self.tableView.dataSource = _reviewDataSource;
}
@end
