//
//  DWAddReagentCell.m
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "NSString+Check.h"
#import "SXQSupplier.h"
#import "DWReagentOption.h"
#import "DWReagentSecondClarify.h"
#import "MBProgressHUD+MJ.h"
#import "DWAddExpReagent.h"
#import "DWReagentFirstClarify.h"
#import "DWAddItemToolImpl.h"
#import "DWAddReagentViewModel.h"
#import "DWTextField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWAddReagentCell.h"
@interface DWAddReagentCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet DWTextField *supplier;
@property (weak, nonatomic) IBOutlet DWTextField  *firstField;
@property (weak, nonatomic) IBOutlet DWTextField *secondField;
@property (weak, nonatomic) IBOutlet DWTextField *reagentNameField;
@property (weak, nonatomic) IBOutlet DWTextField *amountField;
@property (nonatomic,strong) id<DWAddItemTool> addItemTool;
@property (nonatomic,strong) SXQSupplier *customSupplier;
@end
@implementation DWAddReagentCell
- (SXQSupplier *)customSupplier
{
    if (!_customSupplier) {
        _customSupplier = [SXQSupplier new];
        _customSupplier.supplierID = [NSString uuid];
    }
    return _customSupplier;
}
- (id<DWAddItemTool>)addItemTool
{
    if (!_addItemTool) {
        _addItemTool = [[DWAddItemToolImpl alloc] init];
    }
    return _addItemTool;
}
- (void)setReagentViewModel:(DWAddReagentViewModel *)reagentViewModel
{
    _reagentViewModel = reagentViewModel;
    [self bindingViewModel];
}
- (void)bindingViewModel
{
    @weakify(self)
    [[self.supplier.rac_textSignal
     filter:^BOOL(NSString *text) {
         return text.length > 0;
     }]
    subscribeNext:^(NSString *supplierName) {
        @strongify(self)
        self.customSupplier.supplierName = supplierName;
        self.reagentViewModel.expReagent.supplier = self.customSupplier;
        self.supplier.text = self.customSupplier.supplierName ;
    }];
    RAC(self.firstField,text) = RACObserve(self.reagentViewModel, firstClass);
    RAC(self.secondField,text) = RACObserve(self.reagentViewModel, secondClass);
    RAC(self.reagentNameField,text) = RACObserve(self.reagentViewModel, reagentName);
    RAC(self.reagentViewModel,amount) =[[self.amountField.rac_textSignal
                                         filter:^BOOL(NSString *amount) {
                                            if (![amount dg_isNumber]) {
                                                [MBProgressHUD showError:@"请输入数字"];
                                            }                                     
                                             return [amount dg_isNumber];
                                         }]
                                         map:^id(NSString *amount) {
                                             return @([amount integerValue]);
                                         }];
    RAC(self.supplier,text) = RACObserve(self.reagentViewModel, supplier);
    
    [self bindingCommand];
}

- (void)bindingCommand
{
    @weakify(self)
    [[[self.firstField.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]
    subscribeNext:^(id x) {
        @strongify(self)
        [self p_showFirstPicker];
    }];
    
    [[[[[self.secondField.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]
      map:^id(id value) {
          return @(self.reagentViewModel.expReagent.levelOneID ? YES : NO);
      }]
     filter:^BOOL(NSNumber *levelChoosed) {
         if (![levelChoosed boolValue]) {
             [MBProgressHUD showError:@"请先选择一级分类"];
         }
         return [levelChoosed boolValue];
     }]
    subscribeNext:^(id x) {
        @strongify(self)
        [self p_showSecondPicker];
    }];
    
   [[[[self.reagentNameField.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]
    flattenMap:^RACStream *(id value) {
        return [self p_reagentCanChooseSignal];
    }]
    subscribeNext:^(id x) {
        @strongify(self)
        [self p_showReagentPicker];
    }];
    
    [[[[[[self.supplier.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_prepareForReuseSignal]
       doNext:^(id x) {
           [self.amountField resignFirstResponder];
       }]
     flattenMap:^RACStream *(id value) {
         return [self p_reagentNameValidSinal];
     }]
     filter:^BOOL(NSNumber *validSignal) {
         if (![validSignal boolValue]) {
             [MBProgressHUD showError:@"请先填写试剂"];
         }
         return [validSignal boolValue];
     }]
    subscribeNext:^(id x) {
        @strongify(self)
        [self.addItemTool showSupplierWithOrigin:self.supplier itemType:DWAddItemTypeReagent itemID:self.reagentViewModel.expReagent.reagentID handler:^(SXQSupplier *supplier) {
            self.reagentViewModel.expReagent.supplier = supplier;
            self.supplier.text = supplier.supplierName;
        }];
    }];

}
- (RACSignal *)p_reagentCanChooseSignal
{
    RACSignal *showPickerSignal = [[self p_levelValidSignal] filter:^BOOL(NSNumber *leveValid) {
        if (![leveValid boolValue]) {
            [MBProgressHUD showError:@"请先选择分类"];
        }
        return [leveValid boolValue];
    }];
    return showPickerSignal;
}
- (RACSignal *)p_levelValidSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(self.reagentViewModel.expReagent.levelOneID && self.reagentViewModel.expReagent.levelTwoID)];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)p_reagentNameValidSinal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(self.reagentViewModel.expReagent.reagentID ? YES : NO)];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.firstField]) {
        [self p_showFirstPicker];
        return NO;
    }else if([textField isEqual:self.secondField])
    {
        if(!self.reagentViewModel.expReagent.levelOneID)
        {
             [MBProgressHUD showError:@"请先选择一级分类"];
            return NO;
        }
        [self p_showSecondPicker];
        return NO;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.reagentNameField]) {
        self.reagentViewModel.expReagent.reagentID = [NSString uuid];
        self.reagentViewModel.expReagent.reagentName = textField.text;
    }
}
#pragma mark - Picker Method
- (void)p_showFirstPicker
{
    [self.addItemTool showFirstPickerWithOrigin:self.firstField.rightButton handler:^(DWReagentFirstClarify *firstClarify) {
            self.firstField.text = firstClarify.levelOneSortName;
            self.reagentViewModel.expReagent.levelOneID = firstClarify.levelOneSortID;
        }];
}
- (void)p_showSecondPicker
{
    [self.addItemTool showSecondPickerWithOrigin:self.secondField levelOne:self.reagentViewModel.expReagent.levelOneID handler:^(DWReagentSecondClarify *secondClarify) {
            self.secondField.text = secondClarify.levelTwoSortName;
            self.reagentViewModel.expReagent.levelTwoID = secondClarify.levelTwoSortID;
        }];
}
- (void)p_showReagentPicker
{
    [self.addItemTool showReagentWithOrigin:self.reagentNameField  levelOne:self.reagentViewModel.expReagent.levelOneID levelTwo:self.reagentViewModel.expReagent.levelTwoID handler:^(DWReagentOption *reagentOption) {
           self.reagentViewModel.expReagent.reagentID = reagentOption.reagentID;
           self.reagentViewModel.expReagent.reagentName = reagentOption.reagentName;
           self.reagentNameField.text = reagentOption.reagentName;
       }];
}
@end
