//
//  DWCommentItemViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWCommentItem.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWCommentItemViewModel.h"

@implementation DWCommentItemViewModel
- (instancetype)initWithCommentItem:(DWCommentItem *)commentItem
{
    if (self = [super init]) {
        _commentItem = commentItem;
        _checked = NO;
        _itemName = commentItem.itemName;
        RAC(commentItem,itemScore) = RACObserve(self, checked);
        [self p_setupCommmand];
    }
    return self;
}
- (void)p_setupCommmand
{
    @weakify(self)
    _checkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            self.checked = !self.checked;
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
@end
