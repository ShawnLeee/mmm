//
//  DWBBSWriteComment.m
//  实验助手
//
//  Created by sxq on 15/12/2.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWBBSWriteComment.h"

@interface DWBBSWriteComment ()
@property (nonatomic,weak) IBOutlet UITextView *commentView;
@end

@implementation DWBBSWriteComment

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupNavigationItem];
}
- (void)p_setupNavigationItem
{
    self.title = @"写评论";
    UIColor *normal = [UIColor colorWithRed:0.00 green:0.47 blue:0.85 alpha:1.0];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [cancelButton setTitleColor:normal forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(0, 0, 40, 30);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    @weakify(self)
    [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self)
         [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake(0, 0, 40, 30);
    [sendBtn setTitle:@"发布" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [sendBtn setTitleColor:normal forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    [[sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
        
    }];
    [[_commentView.rac_textSignal
     map:^id(NSString *text) {
         return @(text.length > 0);
     }]
     subscribeNext:^(NSNumber *valide) {
         sendBtn.enabled = [valide boolValue];
    }];
}
@end
