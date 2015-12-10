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
#import "DWAddInstructionServiceImpl.h"
@interface DWAppendInstructionController ()
@property (nonatomic,weak) IBOutlet DWInstructionContainer *instructionContainer;
@property (nonatomic,strong) id<DWAddInstructionService> addInstructionService;
@property (nonatomic,strong) DWAddInstructionViewModel *addInstructionViewModel;
@end

@implementation DWAppendInstructionController
- (id<DWAddInstructionService>)addInstructionService
{
    if (!_addInstructionService) {
        _addInstructionService = [[DWAddInstructionServiceImpl alloc] init];
    }
    return _addInstructionService;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setNavigationBar];
    [self p_setInstructionContainer];
}
- (void)p_setInstructionContainer
{
    self.addInstructionViewModel = [DWAddInstructionViewModel instructionViewModel];
    self.instructionContainer.instructionViewModel = self.addInstructionViewModel.expInstruction;
    self.instructionContainer.addInstructionService = self.addInstructionService;
}
- (void)p_setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"下一步" titleColor:LABBtnBgColor font:15 action:^{
        NSLog(@"%@",_addInstructionViewModel);
    }];
}
@end
