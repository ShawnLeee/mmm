//
//  DWInstructionService.h
//  实验助手
//
//  Created by sxq on 15/11/17.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,SXQExpReagent;
#import <Foundation/Foundation.h>

@protocol DWInstructionService <NSObject>
- (void)pushViewModel:(id)viewModel;
- (RACSignal *)reagentSignalWithReagentModel:(SXQExpReagent *)reagent;
@end
