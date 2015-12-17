//
//  DWAddExpReagent.m
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "NSString+UUID.h"
#import "DWAddExpReagent.h"
#import <MJExtension/MJExtension.h>
#import "SXQSupplier.h"
@implementation DWAddExpReagent
- (instancetype)init
{
    if (self = [super init]) {
        _expReagentID = [NSString uuid];
    }
    return self;
}
- (SXQSupplier *)supplier
{
    if (!_supplier) {
        if (_suppliers.count) {
            _supplier = [_suppliers firstObject];
        }
    }
    return _supplier;
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"suppliers" : [SXQSupplier class]};
}
- (NSString *)expReagentID
{
    if (!_expReagentID) {
        _expReagentID = [NSString uuid];
    }
    return _expReagentID;
}
@end
