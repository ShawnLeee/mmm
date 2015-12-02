//
//  DWBBSToolImpl.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSCommentParam.h"
#import "DWBBSCommentViewModel.h"
#import "DWBBSComment.h"
#import "DWBBSTheme.h"
#import "DWBBSThemeController.h"
#import "SXQHttpTool.h"
#import "DWBBSModel.h"
#import <MJExtension/MJExtension.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWBBSToolImpl.h"
#import "DWBBSCommentController.h"
@interface DWBBSToolImpl ()
@property (nonatomic,weak) UINavigationController *navigationController;
@end
@implementation DWBBSToolImpl
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController
{
    if (self =[super init]) {
        _navigationController = navigationController;
    }
    return self;
}
- (void)bbsPushModel:(id)model
{
    if ([model isKindOfClass:[DWBBSModel class]]) {
        [self p_pushBBSModel:model];
    }else if([model isKindOfClass:[DWBBSTheme class]])
    {
        [self p_pushThemeModel:model];
    }
}
- (void)p_pushThemeModel:(DWBBSTheme *)themeModel
{
    DWBBSCommentController *commentVC = [[DWBBSCommentController alloc] initWithBBSTheme:themeModel bbsTool:self];
    [self.navigationController pushViewController:commentVC animated:YES];
}
- (void)p_pushBBSModel:(DWBBSModel *)bbsModel
{
    DWBBSThemeController *bbsThemeVC = [[DWBBSThemeController alloc] initWithBBSModel:bbsModel bbsTool:self];
    [self.navigationController pushViewController:bbsThemeVC animated:YES];
}
- (RACSignal *)bbsModulesSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:BBSModulesURL params:nil success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *bbsModels = [DWBBSModel objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:bbsModels];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (RACSignal *)themesWithBBSModel:(DWBBSModel *)bbsModel
{
    NSDictionary *param = @{@"moduleID" : bbsModel.moduleID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:BBSThemesURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *themes = [DWBBSTheme objectArrayWithKeyValuesArray:json[@"data"]];
                [subscriber sendNext:themes];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (RACSignal *)commentsSignalWithBBSTheme:(DWBBSTheme *)bbsTheme
{
    NSDictionary *param = @{@"topicID" : bbsTheme.topicID};
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:BBSCommentsURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *comments = [DWBBSComment objectArrayWithKeyValuesArray:json[@"data"][@"reviews"]];
                NSArray *viewModels = [self p_viewModleArrayWithCommentArray:comments];
                [subscriber sendNext:viewModels];
                [subscriber sendCompleted];
            }else
            {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
            }
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (NSArray *)p_viewModleArrayWithCommentArray:(NSArray *)commentArray
{
    __block NSMutableArray *tmpArray = [NSMutableArray array];
    [commentArray enumerateObjectsUsingBlock:^(DWBBSComment *comment, NSUInteger idx, BOOL * _Nonnull stop) {
        DWBBSCommentViewModel *viewModel = [[DWBBSCommentViewModel alloc] initWithComment:comment bbsTool:self];
        [tmpArray addObject:viewModel];
    }];
    return [tmpArray copy];
}
- (RACSignal *)commentWithParam:(DWBBSCommentParam *)param
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool postWithURL:BBSWriteCommentURL params:param.keyValues success:^(id json) {
            BOOL success = [json[@"code"] isEqualToString:@"1"];
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];  
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
@end
