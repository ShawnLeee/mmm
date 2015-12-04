//
//  DWBBSThemeView.h
//  实验助手
//
//  Created by sxq on 15/12/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWBBSTopic;
#import <UIKit/UIKit.h>

@interface DWBBSThemeView : UIView
+ (instancetype)themeView;
@property (nonatomic,strong) DWBBSTopic *bbsTopic;
@end
