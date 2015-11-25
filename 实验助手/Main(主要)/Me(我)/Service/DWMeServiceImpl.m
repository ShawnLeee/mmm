//
//  DWMeServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMeServiceImpl.h"
#import "DWMeItem.h"
#import <MJExtension/MJExtension.h>
#import "SXQDBManager.h"
#import "SXQExpInstruction.h"
@implementation DWMeServiceImpl
- (RACSignal *)meItemsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"me.plist" ofType:nil];
        NSArray *items = [DWMeItem objectArrayWithFile:filePath];
        [subscriber sendNext:items];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)allInstructionsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSArray *dictArr = [[SXQDBManager sharedManager] meAllInstructions];
        NSArray *modelArr =  [SXQExpInstruction objectArrayWithKeyValuesArray:dictArr];
        [subscriber sendNext:modelArr];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)signUpModelsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"signup.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//        DWSignUpGroup *group = [DWSignUpGroup objectWithKeyValues:dict];
//        [subscriber sendNext:[self groupsWithSignUpGrop:group]];
//        [subscriber sendCompleted];
        return nil;
    }];
}
@end
