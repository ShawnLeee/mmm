//
//  CellContainerViewModel.m
//  实验助手
//
//  Created by SXQ on 15/10/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CellContainerViewModel.h"
#import "SXQExpStep.h"
#import "UILocalNotification+DG.h"
#import "DWExperimentCell.h"
#import "SXQDBManager.h"
@interface CellContainerViewModel ()
@property (nonatomic,strong) id<SXQExperimentServices> service;
@property (nonatomic,strong) SXQExpStep *experimentStep;
@end

@implementation CellContainerViewModel
- (NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)addImage:(UIImage *)image
{
    [self insertObject:image inImagesAtIndex:self.images.count];
       //添加到数据库
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SXQDBManager sharedManager] addImageWithMyExpId:self.experimentStep.myExpId expInstructionId:self.experimentStep.expInstructionID expStepId:self.experimentStep.expStepID image:image];
    });
}
- (void)insertObject:(UIImage *)object inImagesAtIndex:(NSUInteger)index
{
    [self.images insertObject:object atIndex:index];
}
- (void)removeObjectFromImagesAtIndex:(NSUInteger)index
{
    [self.images removeObjectAtIndex:index];
}
+ (instancetype)viewModelWithExpStep:(SXQExpStep *)expStep service:(id<SXQExperimentServices>)service
{
    CellContainerViewModel *viewModel = [[CellContainerViewModel alloc] init];
    viewModel.experimentStep = expStep;
    viewModel.service = service;
    viewModel.startButtonActive = YES;
    return viewModel;
}
-(void)setExperimentStep:(SXQExpStep *)experimentStep
{
    _experimentStep = experimentStep;
    _stepImageName = [NSString stringWithFormat:@"step%d",experimentStep.stepNum];
    _stepDesc = experimentStep.expStepDesc;
    self.images = experimentStep.images;
    
    @weakify(self)
    [RACObserve(experimentStep, processMemo) subscribeNext:^(NSString *processMemo) {
        @strongify(self)
        self.processMemo = processMemo;
    }];
    
    [RACObserve(experimentStep, expStepTime) subscribeNext:^(NSString *stepTime) {
        @strongify(self)
        self.stepTime = [stepTime doubleValue] * 60;
    }];
   [RACObserve(self, images)
    subscribeNext:^(NSMutableArray *images) {
        self.experimentStep.images = images;
    }];
    [RACObserve(experimentStep, isUserTimer) subscribeNext:^(NSNumber *isUseTimer) {
        @strongify(self)
        self.isUseTimer = [isUseTimer boolValue];
    }];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_setupSelf];
    }
    return self;
}
- (void)p_setupSelf
{
    @weakify(self)
    _timeChooseCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal empty];
    }];
    _addImageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return  [self.service imagePickedSignal];
    }];
    
    
    _addMemoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [self.service remarkAddSignalWithViewModel:self];
    }];
    
    
    _startCommand = [[RACCommand alloc] initWithEnabled:RACObserve(self, startButtonActive) signalBlock:^RACSignal *(id input) {
                        return [self.service launchSignalWithViewModel:self];
                    }];
}
- (void)p_setupButtonBusiness
{
    @weakify(self)
    [[[_addImageCommand.executionSignals
      switchToLatest]
     takeUntil:self.cell.rac_prepareForReuseSignal]
     subscribeNext:^(UIImage *image) {
         @strongify(self)
         if(image)
         {
             [self addImage:image];
             if(self.updateCellBlock)
             {
                 self.updateCellBlock();
             }    
         }
    }];
    
    [[[_addMemoCommand.executionSignals
    switchToLatest]
    takeUntil:self.cell.rac_prepareForReuseSignal]
    subscribeNext:^(CellContainerViewModel *viewModel) {
        if (viewModel) {
            [self saveMemo];
            self.updateCellBlock();
        }
    }];
    [[[_startCommand.executionSignals
    switchToLatest]
    takeUntil:self.cell.rac_prepareForReuseSignal]
    subscribeNext:^(id x) {
        
    }];
}
- (void)countTimeView:(SXQCountTimeView *)timeView choosedTime:(NSTimeInterval)time
{
    self.stepTime = time;
    [timeView hide];
}

-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime
{
    [UILocalNotification localNotificationWithBody:self.description timeIntervel:0 indentifier:@"sss"];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@",[super description],@{@"images" : self.images}];
}
- (void)saveMemo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SXQDBManager sharedManager] updateMyExpProcessMemoWithExpProcessID:self.experimentStep.myExpProcessId
                                                                 processMemo:self.processMemo];
    });
}
@end
