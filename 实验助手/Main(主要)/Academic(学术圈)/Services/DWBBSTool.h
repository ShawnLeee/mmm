//
//  DWBBSTool.h
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class RACSignal,DWBBSTheme,DWBBSModel;
#import <Foundation/Foundation.h>

@protocol DWBBSTool <NSObject>
- (RACSignal *)bbsModulesSignal;
- (void)bbsPushModel:(id)model;
- (RACSignal *)themesWithBBSModel:(DWBBSModel *)bbsModel;
- (RACSignal *)commentsSignalWithBBSTheme:(DWBBSTheme *)bbsTheme;
@end
