//
//  DWMeService.h
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal;
#import <Foundation/Foundation.h>

@protocol DWMeService <NSObject>
- (RACSignal *)meItemsSignal;
- (RACSignal *)allInstructionsSignal;
- (RACSignal *)userInfoSignal;
- (RACSignal *)uploadUserProfile;
- (void)signOut;
- (RACSignal *)uploadInstructionWithInstrucitonID:(NSString *)instructionID allowDownload:(int)allowDownload;
- (RACSignal *)addExpInstructionInstructionID:(NSString *)instructionID;
/**
 *  Get local instructions
 *
 *  @return NSArray<DWAddExpInstruction *>
 */
- (RACSignal *)localInstructions;
@end
