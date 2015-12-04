//
//  DWBBSThemeView.m
//  实验助手
//
//  Created by sxq on 15/12/4.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSTopic.h"
#import "DWBBSThemeView.h"
@interface DWBBSThemeView ()
@property (nonatomic,weak) IBOutlet UILabel *themeLabel;
@property (nonatomic,weak) IBOutlet UILabel *themeContentLabel;
@end
@implementation DWBBSThemeView
+ (instancetype)themeView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DWBBSThemeView class]) owner:nil options:nil] lastObject];
}
- (void)setBbsTopic:(DWBBSTopic *)bbsTopic
{
    _bbsTopic = bbsTopic;
    self.themeLabel.text = bbsTopic.topicName;
    self.themeContentLabel.text = bbsTopic.topicDetail;
}
@end
