//
//  DWAddConsumableCell.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddConsumabelViewModel.h"
#import "DWAddConsumableCell.h"
#import "DWTextField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD+MJ.h"
#import "NSString+Check.h"
@interface DWAddConsumableCell ()
@property (nonatomic,weak) IBOutlet DWTextField *consumableNameField;
@property (nonatomic,weak) IBOutlet UITextField *amountField;
@property (nonatomic,weak) IBOutlet DWTextField *supplierField;
@end
@implementation DWAddConsumableCell
- (void)setConsumableViewModel:(DWAddConsumabelViewModel *)consumableViewModel
{
    _consumableViewModel = consumableViewModel;
    RAC(self.consumableNameField,text) = [RACObserve(self.consumableViewModel, consumableName) takeUntil:self.rac_prepareForReuseSignal];
    RAC(self.supplierField,text) = [RACObserve(self.consumableViewModel, supplierName) takeUntil:self.rac_prepareForReuseSignal];
    
    RAC(self.consumableViewModel,amout) = [[[[self.amountField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal ]
                                           doNext:^(NSString *amountText) {
                                               if (![amountText dg_isNumber]) {
                                                   [MBProgressHUD showError:@"请输入数字"];
                                               }
                                           }]
                                           filter:^BOOL(NSString *amountText) {
                                               return [amountText dg_isNumber];
                                           }]
                                           map:^id(NSString *amountText) {
                                               return @([amountText integerValue]);
                                           }];
}


@end
