//
//  DWAddExpReagent.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "DWAddExpReagent.h"

@implementation DWAddExpReagent
- (instancetype)init
{
    if (self = [super init]) {
        _expReagentID = [NSString uuid];
    }
    return self;
}
@end
