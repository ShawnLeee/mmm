//
//  DWBBSCommentController.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJRefresh.h>
#import "SXQNavgationController.h"
#import "DWBBSCommentViewModel.h"
#import "DWBBSWriteComment.h"
#import "DWBBSCommentCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWBBSTheme.h"
#import "DWBBSCommentController.h"
#import "DWBBSCommentParam.h"
@interface DWBBSCommentController ()
@property (nonatomic,strong) DWBBSTheme *bbsTheme;
@property (nonatomic,strong) id<DWBBSTool> bbsTool;
@property (nonatomic,strong) NSArray *comments;
@end

@implementation DWBBSCommentController
- (instancetype)initWithBBSTheme:(DWBBSTheme *)bbsTheme bbsTool:(id<DWBBSTool>)bbsTool
{
    if (self = [super init]) {
        _bbsTheme = bbsTheme;
        _bbsTool = bbsTool;
        _comments = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupRefresh];
//    [self p_loadData];
    [self p_setupTableView];
    [self p_setupNavigation];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.tableView.header)
    {
        [self.tableView.header beginRefreshing];
    }
}
#pragma mark - 下拉刷新
- (void)p_setupRefresh
{
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        @weakify(self)
        [[self.bbsTool commentsSignalWithBBSTheme:_bbsTheme]
         subscribeNext:^(NSArray *comments) {
             @strongify(self)
             self.comments = comments;
             [self.tableView reloadData];
             [self.tableView.header endRefreshing];
         }];
    }];
    
    self.tableView.header = header;
    [self.tableView.header beginRefreshing];
}
- (void)p_setupNavigation
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor colorWithRed:0.00 green:0.47 blue:0.85 alpha:1.0] forState:UIControlStateNormal];
    [button setTitle:@"写评论" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0,60, 21);
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         DWBBSCommentParam *param = [DWBBSCommentParam paramWithTopicID:_bbsTheme.topicID parentReviewID:nil];
         [self p_showWriteCommentControllerWithParam:param];
    }];
}

- (void)p_setupTableView
{
    self.title = @"评论";
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWBBSCommentCell class]) bundle:nil] forCellReuseIdentifier: NSStringFromClass([DWBBSCommentCell class])];
}
- (void)p_loadData
{
    @weakify(self)
    [[self.bbsTool commentsSignalWithBBSTheme:_bbsTheme]
    subscribeNext:^(NSArray *comments) {
        @strongify(self)
        self.comments = comments;
        [self.tableView reloadData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWBBSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWBBSCommentCell class]) forIndexPath:indexPath];
    cell.viewModel = self.comments[indexPath.row];
    return cell;
}
#pragma mark - TableView Deleagate Method 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"回复", nil];
    [[actionSheet rac_buttonClickedSignal]
    subscribeNext:^(NSNumber *buttonIndex) {
       if([buttonIndex longValue] == 0)
       {
           DWBBSCommentViewModel *viewModel = self.comments[indexPath.row];
           DWBBSCommentParam *param = [DWBBSCommentParam paramWithTopicID:_bbsTheme.topicID parentReviewID:viewModel.reviewID];
           [self p_showWriteCommentControllerWithParam:param];
       }
    }];
    [actionSheet showInView:self.view];
    
}
- (void)p_showWriteCommentControllerWithParam:(DWBBSCommentParam *)param;
{
    DWBBSWriteComment *writeCommentVC = [[DWBBSWriteComment alloc] initWithCommentParam:param bbsTool:self.bbsTool];
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:writeCommentVC];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
