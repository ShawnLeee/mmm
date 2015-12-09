//
//  DWAppendInstructionController.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAddInstructionViewModel.h"
#import "UIBarButtonItem+SXQ.h"
#import "DWAppendInstructionController.h"
#import "DWInstructionContainer.h"

@interface DWAppendInstructionController ()
@property (nonatomic,weak) IBOutlet DWInstructionContainer *instructionContainer;
@end

@implementation DWAppendInstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setNavigationBar];
    [self p_setInstructionContainer];
}
- (void)p_setInstructionContainer
{
    self.instructionContainer.instructionViewModel = [[DWAddInstructionViewModel instructionViewModel] expInstruction];
}
- (void)p_setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"下一步" titleColor:LABBtnBgColor font:15 action:^{
        
    }];
}
@end
