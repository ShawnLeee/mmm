//
//  DWAddStepViewModel.h
//  实验助手
//
//  Created by sxq on 15/12/15.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWAddStepViewModel : NSObject
@property (nonatomic,assign) NSUInteger stepNum;
@property (nonatomic,copy) NSString *stepContent;
@property (nonatomic,copy) NSString *stepTime;
@property (nonatomic,copy) NSString *stepImageName;
- (instancetype)initWithStepNum:(NSUInteger)stepNum;
@end
