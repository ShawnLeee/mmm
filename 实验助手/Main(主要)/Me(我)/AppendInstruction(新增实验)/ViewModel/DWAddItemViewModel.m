//
//  DWAddItemViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddExpEquipment.h"
#import "DWAddEquipmentController.h"
#import "DWAddReagentViewModel.h"
#import "SXQNavgationController.h"
#import "DWAddReagentController.h"
#import "DWAddReagentViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddItemViewModel.h"
#import "DWItemCellViewModel.h"
#import "DWAddConsumableController.h"
#import "DWAddExpConsumable.h"
typedef void (^AddDoneBlock)(id itemModel);
@interface DWAddItemViewModel ()
@property (nonatomic,strong) id<DWAddInstructionService> service;
@end
@implementation DWAddItemViewModel
- (instancetype)initWithItemName:(NSString *)itemName
                        itemType:(DWAddItemType)itemType
                         service:(id<DWAddInstructionService>)service
                   instructionID:(NSString *)instructionID
{
    if (self = [super init]) {
        self.instructionID = instructionID;
        _itemType = itemType;
        _itemName = itemName;
        _service = service;
        _items = [NSMutableArray array];
        _addCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [self pushVCWithItemType:self.itemType];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}
- (void)pushVCWithItemType:(DWAddItemType)itemType
{
    id viewController = nil;
    switch (itemType) {
        case DWAddItemTypeReagent:
        {
            DWAddReagentController *reagentVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DWAddReagentController class])];
            reagentVC.instrucitonID = self.instructionID;
            reagentVC.doneBlock = ^(DWAddReagentViewModel *reagentViewModel)
            {
                DWItemCellViewModel *cellViewModel = [[DWItemCellViewModel alloc] initWithModel:reagentViewModel.expReagent];
                [self.items addObject:cellViewModel];
                [self.service refreshData];
            };
            viewController = reagentVC;
            break;
        }
        case DWAddItemTypeConsumable:
        {
            DWAddConsumableController *consumableVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DWAddConsumableController class])];
            consumableVC.doneBlock = ^(DWAddExpConsumable *addExpConsumable){
                DWItemCellViewModel *cellViewModel = [[DWItemCellViewModel alloc] initWithModel:addExpConsumable];
                [self.items addObject:cellViewModel];
                [self.service refreshData];
            };
            viewController = consumableVC;
            break;
        }
        case DWAddItemTypeEquipment:
        {
            DWAddEquipmentController *equipmentVC = [[UIStoryboard storyboardWithName:@"AddItem" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DWAddEquipmentController class])];
            equipmentVC.doneBlock = ^(DWAddExpEquipment *addExpEquipment)
            {
                DWItemCellViewModel *cellViewModel = [[DWItemCellViewModel alloc] initWithModel:addExpEquipment];
                [self.items addObject:cellViewModel];
                [self.service refreshData];
            };
            viewController = equipmentVC;
            break;
        }
    }
    SXQNavgationController *nav = [[SXQNavgationController alloc] initWithRootViewController:viewController];
    [self.service presentViewController:nav];
}
@end
