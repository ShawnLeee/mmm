//
//  DWReagentSearchModel.m
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "DWReagentSearchModel.h"
#import "SXQSupplier.h"
@implementation DWReagentSearchModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"suppliers" : [SXQSupplier class]};
}
@end
