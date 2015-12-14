//
//  DWAddEquipmentCell.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddEquipmentViewModel.h"
#import "DWAddEquipmentCell.h"
#import "DWTextField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWAddEquipmentCell ()
@property (nonatomic,weak) IBOutlet DWTextField *equipmentNameField;
@property (nonatomic,weak) IBOutlet DWTextField *supplierField;
@end
@implementation DWAddEquipmentCell
- (void)setEquipmentViewModel:(DWAddEquipmentViewModel *)equipmentViewModel
{
    _equipmentViewModel = equipmentViewModel;
    [self p_bindingViewModel];
}
- (void)p_bindingViewModel
{
    RAC(self.equipmentNameField,text) = [RACObserve(self.equipmentViewModel, equipmentName) takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.supplierField,text) = [RACObserve(self.equipmentViewModel,supplierName) takeUntil:self.rac_prepareForReuseSignal];
}
@end
