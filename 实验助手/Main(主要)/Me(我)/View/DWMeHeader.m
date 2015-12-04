//
//  DWMeHeader.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "DWMeHeader.h"
@interface DWMeHeader ()
@property (nonatomic,weak) IBOutlet UIView *headerView;
@property (nonatomic,weak) IBOutlet UIImageView *userIcon;
@property (nonatomic,weak) IBOutlet UILabel *userName;
@property (nonatomic,weak) IBOutlet UIButton *headerButton;
@property (nonatomic,assign) BOOL didSetupConstraints;
@end
@implementation DWMeHeader
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self p_setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_setup];
    }
    return self;
}
- (void)p_setup
{
    _didSetupConstraints = NO;
    self.frame = CGRectMake(0, 0, 300, 80);
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DWMeHeader class]) owner:self options:nil];
    [self addSubview:_headerView];
    _headerView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self setNeedsUpdateConstraints];
}
- (void)updateConstraints
{
    if (!_didSetupConstraints) {
        [self p_setupConstaints];
        _didSetupConstraints = YES;
    }
    [super updateConstraints];
}
- (void)p_setupConstaints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
}
- (IBAction)buttonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(dw_meHeader:didClickedHeaderButton:)]) {
        [self.delegate dw_meHeader:self didClickedHeaderButton:sender];
    }
}
@end
