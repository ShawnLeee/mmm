//
//  DWAddExpReagent.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class SXQSupplier;
#import <Foundation/Foundation.h>

@interface DWAddExpReagent : NSObject
@property (nonatomic,copy) NSString *expReagentID;
@property (nonatomic,copy) NSString *expInstructionID;
@property (nonatomic,copy) NSString *reagentID;
@property (nonatomic,copy) NSString *reagentName;
@property (nonatomic,copy) NSString *useAmount;
@property (nonatomic,strong) SXQSupplier *supplier;
@end
