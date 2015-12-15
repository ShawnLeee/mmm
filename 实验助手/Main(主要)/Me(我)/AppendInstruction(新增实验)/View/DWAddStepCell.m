//
//  DWAddStepCell.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWAddStepCell.h"
#import "DWAddStepViewModel.h"
@interface DWAddStepCell ()
@property (nonatomic,weak) IBOutlet UIImageView *stepImageView;
@end
@implementation DWAddStepCell

- (void)setStepViewModel:(DWAddStepViewModel *)stepViewModel
{
    _stepViewModel = stepViewModel;
    self.stepImageView.image = [UIImage imageNamed:stepViewModel.stepImageName];
}
@end
