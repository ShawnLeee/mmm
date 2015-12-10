//
//  DWAddInstructionServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddItemViewModel.h"
#import "SXQExpCategory.h"
#import "SXQExpSubCategory.h"
#import <MJExtension/MJExtension.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQHttpTool.h"
#import "DWAddInstructionServiceImpl.h"
@interface DWAddInstructionServiceImpl ()
@property (nonatomic,weak) UINavigationController *navigationController;
@end
@implementation DWAddInstructionServiceImpl
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    if (self = [super init]) {
        self.navigationController = navigationController;
    }
    return self;
}
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
- (RACSignal *)itemViewModelSignalWithInstructionID:(NSString *)instructionID
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        DWAddItemViewModel *itemViewModel0 = [[DWAddItemViewModel alloc] initWithItemName:@"添加试剂" itemType:DWAddItemTypeReagent service:self instructionID:instructionID];
        DWAddItemViewModel *itemViewModel1 = [[DWAddItemViewModel alloc] initWithItemName:@"添加耗材" itemType:DWAddItemTypeConsumable service:self instructionID:instructionID];
        DWAddItemViewModel *itemViewModel2 = [[DWAddItemViewModel alloc] initWithItemName:@"添加设备" itemType:DWAddItemTypeEquipment service:self instructionID:instructionID];
        NSArray *itemViewModels = @[itemViewModel0,itemViewModel1,itemViewModel2];
        [subscriber sendNext:itemViewModels];
        [subscriber sendCompleted];
        return nil;
    }];
    return nil;
}
- (void)presentViewController:(UIViewController *)viewControllerToPresent
{
    [self.navigationController presentViewController:viewControllerToPresent animated:YES completion:nil];
}
@end
