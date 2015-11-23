//
//  DWExperimentToolBar.m
//  实验助手
//
//  Created by SXQ on 15/10/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWExperimentToolBar.h"
@interface DWExperimentToolBar ()
@property (nonatomic,weak) IBOutlet UIView *view;


@end
@implementation DWExperimentToolBar
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self p_setupSelf];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupSelf];
    }
    return self;
}
- (void)p_setupSelf
{
    [[NSBundle mainBundle] loadNibNamed:@"DWExperimentToolBar" owner:self options:nil];
    [self addSubview:_view];
    _view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[_view.leadingAnchor constraintEqualToAnchor:self.leadingAnchor]];
    [self addConstraint:[_view.topAnchor constraintEqualToAnchor:self.topAnchor]];
    [self addConstraint:[_view.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]];
    [self addConstraint:[_view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]];
}
@end
