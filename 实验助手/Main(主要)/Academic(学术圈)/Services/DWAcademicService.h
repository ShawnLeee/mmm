//
//  DWAcademicService.h
//  实验助手
//
//  Created by sxq on 15/10/28.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWAcademicTool.h"
#import <Foundation/Foundation.h>

@protocol DWAcademicService <NSObject>
- (id<DWAcademicTool>)getService;
@end
