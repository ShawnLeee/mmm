//
//  DWAddInstructionServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpCategory.h"
#import "SXQExpSubCategory.h"
#import <MJExtension/MJExtension.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQHttpTool.h"
#import "DWAddInstructionServiceImpl.h"

@implementation DWAddInstructionServiceImpl
- (RACSignal *)firstCategorySignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:AllExpURL params:nil success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *categories = [SXQExpCategory mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:categories];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
            }
            
        } failure:^(NSError *error) {
            [subscriber sendNext:@[]];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
- (RACSignal *)secondCategorySignalWithCategoryID:(NSString *)categoryID
{
    NSDictionary *param = @{@"expCategoryID" : categoryID? : @""};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:SubExpURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *categories = [SXQExpSubCategory mj_objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:categories];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:@[]];
                [subscriber sendCompleted];
            }
            
        } failure:^(NSError *error) {
            [subscriber sendNext:@[]];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}
@end
