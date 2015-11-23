//
//  DWDoingCell.m
//  实验助手
//
//  Created by sxq on 15/11/13.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWDoingViewModel.h"
#import "DWDoingActionBar.h"
#import "DWDoingContentView.h"

#import "DWDoingCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWDoingCell ()
@property (nonatomic,weak) IBOutlet DWDoingContentView *experimentContentView;
@property (nonatomic,weak) IBOutlet DWDoingActionBar *actionBar;
@end
@implementation DWDoingCell
- (void)setViewModel:(DWDoingViewModel *)viewModel
{
    _viewModel = viewModel;
    self.experimentContentView.viewModel = viewModel;
    self.experimentContentView.cell = self;
    self.actionBar.viewModel = viewModel;
}
@end
