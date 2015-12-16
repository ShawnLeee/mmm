//
//  DWAddStepViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ActionSheetDatePicker.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddStepViewModel.h"
#import "DWAddExpStep.h"
@interface DWAddStepViewModel ()
@property (nonatomic,assign) NSUInteger stepTime;
@end
@implementation DWAddStepViewModel
- (instancetype)initWithInstructionID:(NSString *)instructionID
{
    if (self = [super init]) {
        self.addExpStep = [[DWAddExpStep alloc] initWithInstructionID:instructionID];
        [self p_setupTimeCommand];
    }
    return self;
}
- (void)setAddExpStep:(DWAddExpStep *)addExpStep
{
    _addExpStep = addExpStep;
    _stepTime = addExpStep.expStepTime;
    _stepNum = addExpStep.stepNum;
    
    [self bindingModel];
}
- (void)bindingModel
{
    RAC(self.addExpStep,expStepDesc) = RACObserve(self, stepContent);
    
    RAC(self.addExpStep,expStepTime) = RACObserve(self, stepTime);
    RAC(self,stepTimeStr) = [RACObserve(self, stepTime)
                             map:^id(NSNumber *stepTime) {
                                 if ([stepTime integerValue] == 0) {
                                     return @"设置时间";
                                 }else
                                 {
                                     return [NSString stringWithFormat:@"%ld分钟",[stepTime integerValue]];
                                 }
                            }];
    RAC(self.addExpStep,stepNum) = RACObserve(self, stepNum);
    
}
- (NSString *)stepImageName
{
    NSString *imageName = [NSString stringWithFormat:@"step%lu",(unsigned long)_stepNum];
    return imageName;
}
- (void)p_setupTimeCommand
{
    _chooseTimeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self showTimePickerWithOrigin:input];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (void)showTimePickerWithOrigin:(id)origin
{
    [ActionSheetDatePicker showPickerWithTitle:@"" datePickerMode:UIDatePickerModeCountDownTimer selectedDate:nil doneBlock:^(ActionSheetDatePicker *picker, NSNumber *seconds, id origin) {
        self.stepTime = [seconds integerValue]/60;
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:origin];
}
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    self.stepNum = indexPath.row + 1;
}
@end
