//
//  SXQScheduleServices.h
//  实验助手
//
//  Created by sxq on 15/10/21.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQSchedule.h"
#import <Foundation/Foundation.h>

@protocol SXQScheduleServices <NSObject>
- (id<SXQSchedule>)getServices;
@end
