//
//  DWCommentHeaderViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCommentItem.h"
#import "DWCommentGroup.h"
#import "DWCommentItemViewModel.h"
#import "DWCommentHeaderViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWCommentHeaderViewModel ()
@end
@implementation DWCommentHeaderViewModel
- (instancetype)initWithCommentGroup:(DWCommentGroup *)commentGroup
{
    if (self = [super init]) {
        _commentGroup = commentGroup;
        self.groupName = commentGroup.expReviewOptName;
        self.items = [self commentItemViewModelArrayWithItemArray:commentGroup.expReviewDetailOfOpts];
        RAC(commentGroup,expReviewOptScore) = RACObserve(self, groupScore);
    }
    return self;
}
- (NSArray *)commentItemViewModelArrayWithItemArray:(NSArray *)commentItems
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [commentItems enumerateObjectsUsingBlock:^(DWCommentItem *commentItem, NSUInteger idx, BOOL * _Nonnull stop) {
        DWCommentItemViewModel *viewModel = [[DWCommentItemViewModel alloc] initWithCommentItem:commentItem];
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
@end
