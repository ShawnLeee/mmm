//
//  DWInstructionContainer.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWInstructionContainer.h"
#import "DWAddExpInstruction.h"
@interface DWInstructionContainer ()<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet UITextField *categoryField;
@property (nonatomic,weak) IBOutlet UITextField *subCategoryField;
@property (nonatomic,weak) IBOutlet UITextField *instructionName;
@property (nonatomic,weak) IBOutlet UITextView *instructionDescView;
@property (nonatomic,weak) IBOutlet UITextView *instructionTheoryView;
@end
@implementation DWInstructionContainer
- (void)setInstructionViewModel:(DWAddExpInstruction *)instructionViewModel
{
    _instructionViewModel = instructionViewModel;
    [self bindingModel];
}
- (void)bindingModel
{
    RAC(_instructionViewModel,experimentName) = self.instructionName.rac_textSignal;
    RAC(_instructionViewModel,experimentDesc) = self.instructionDescView.rac_textSignal;
    RAC(_instructionViewModel,experimentTheory) = self.instructionTheoryView.rac_textSignal;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
@end
