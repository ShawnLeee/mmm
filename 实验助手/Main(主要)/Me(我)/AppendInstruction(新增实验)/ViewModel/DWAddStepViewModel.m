//
//  DWAddStepViewModel.m
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWAddStepViewModel.h"

@implementation DWAddStepViewModel
- (instancetype)initWithStepNum:(NSUInteger)stepNum
{
    if (self = [super init]) {
        _stepNum = stepNum;
    }
    return self;
}
- (NSString *)stepImageName
{
    NSString *imageName = [NSString stringWithFormat:@"step%lu",(unsigned long)_stepNum];
    return imageName;
}
@end
