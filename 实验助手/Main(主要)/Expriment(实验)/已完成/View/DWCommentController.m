//
//  DWCommentController.m
//  实验助手
//
//  Created by sxq on 15/11/23.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "MBProgressHUD+MJ.h"
#import "DWDoingViewModel.h"
#import "UIBarButtonItem+SXQ.h"
#import "DWCommentViewModel.h"
#import "DWCommentController.h"
#import "DWCommentCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWCommentController ()<UITextViewDelegate>
@property (nonatomic,strong) DWDoingViewModel *viewModel;
@property (nonatomic,strong) id<DWDoingModelService> service;
@property (nonatomic,strong) NSArray *viewModels;
@property (nonatomic,weak) UITextView *commentView;
@property (nonatomic,copy) NSString *commentText;
@end

@implementation DWCommentController

- (instancetype)initWithViewModel:(DWDoingViewModel *)viewModel service:(id<DWDoingModelService>)service
{
    if (self = [super init]) {
        _viewModel = viewModel;
        _commentText = @"";
        _service = service;
        _viewModels = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
    [self p_setupSelf];
   
}
- (void)p_loadData
{
    @weakify(self)
    [[self.service commentViewModelSignal]
    subscribeNext:^(NSArray *viewModels) {
        @strongify(self)
        self.viewModels = viewModels;
        [self.tableView reloadData];
    }];
}
- (void)p_setupSelf
{
    self.title = @"评论";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"取消" action:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"确定" action:^{
        if ([self.commentText isEqualToString:@"请输入评论"]) {
            self.commentText = @"";
        }
        [[self.service commentWithExpinstructionID:self.viewModel.expInstructionID
                                          content:self.commentText
                                       viewModels:self.viewModels]
        subscribeNext:^(NSNumber *success) {
            if ([success boolValue]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else
            {
                [MBProgressHUD showError:@"评论失败"];
            }
        }error:^(NSError *error) {
            
        }];
    }];
    self.tableView.allowsSelection = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWCommentCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DWCommentCell class])];
    UITextView *footerView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
   
    _commentView = footerView;
    footerView.delegate = self;
    footerView.text = @"请输入评论";
    footerView.textColor = [UIColor lightGrayColor];
    footerView.font = [UIFont systemFontOfSize:16];
    self.tableView.tableFooterView = footerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWCommentCell class]) forIndexPath:indexPath];
    cell.viewModel = self.viewModels[indexPath.row];
    return cell;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入评论"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"请输入评论";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.commentText = textView.text;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView.tableFooterView resignFirstResponder];
}
@end
