//
//  DWAddInstructionViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/9.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddExpInstruction;
#import <Foundation/Foundation.h>

@interface DWAddInstructionViewModel : NSObject
@property (nonatomic,strong) DWAddExpInstruction *expInstruction;
@property (nonatomic,strong) NSMutableArray *expReagent;
@property (nonatomic,strong) NSMutableArray *expConsumable;
@property (nonatomic,strong) NSMutableArray *expEquipment;
@property (nonatomic,strong) NSMutableArray *expExpStep;
+ (instancetype)instructionViewModel;
@end
