//
//  DWAppendInstructionController.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "UIBarButtonItem+SXQ.h"
#import "DWAppendInstructionController.h"

@interface DWAppendInstructionController ()

@end

@implementation DWAppendInstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setNavigationBar];
}
- (void)p_setNavigationBar
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"下一步" titleColor:LABBtnBgColor font:15 action:^{
        
    }];
}
@end
