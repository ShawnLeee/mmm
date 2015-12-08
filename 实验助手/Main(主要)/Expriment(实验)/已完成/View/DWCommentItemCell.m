//
//  DWCommentItemCell.m
//  实验助手
//
//  Created by sxq on 15/12/8.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "CheckButton.h"
#import "DWCommentItemCell.h"
#import "DWCommentItemViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface DWCommentItemCell ()
@property (nonatomic,weak) IBOutlet CheckButton *checkBtn;
@property (nonatomic,weak) IBOutlet UILabel *itemLabel;
@end
@implementation DWCommentItemCell
- (void)setViewModel:(DWCommentItemViewModel *)viewModel
{
    _viewModel = viewModel;
    self.itemLabel.text = viewModel.itemName;
    self.checkBtn.rac_command = viewModel.checkCommand;
    
    @weakify(self)
     [[RACObserve(viewModel, checked) takeUntil:self.rac_prepareForReuseSignal]
      subscribeNext:^(NSNumber *checked) {
          @strongify(self)
          self.checkBtn.checked = [checked boolValue];
          self.itemLabel.textColor = [checked boolValue]? [UIColor lightGrayColor]:[UIColor blackColor];
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.viewModel.checked = !self.viewModel.checked;
}

@end
