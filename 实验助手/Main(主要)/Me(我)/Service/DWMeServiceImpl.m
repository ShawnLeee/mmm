//
//  DWMeServiceImpl.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "Account.h"
#import "DWUserInfoViewModel.h"
#import "AccountTool.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWMeServiceImpl.h"
#import "DWMeItem.h"
#import <MJExtension/MJExtension.h>
#import "SXQDBManager.h"
#import "SXQExpInstruction.h"
#import "SXQHttpTool.h"
@implementation DWMeServiceImpl
- (RACSignal *)userInfoSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *userID = [[AccountTool account] userID] ? :@"";
        NSDictionary *param = @{@"userID" : userID};
        [SXQHttpTool getWithURL:UserInfoURL params:param success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                 NSArray *viewModels = [self userInfoViewModelWithDict:json[@"data"]];
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
- (NSArray *)userInfoViewModelWithDict:(NSDictionary *)dict
{
    DWUserInfoViewModel *userName = [DWUserInfoViewModel userInforViewModelWithTitle:@"用户名" text:dict[@"nickName"]  idStr:nil editType:MeEditTypeUserName];
    userName.shouldBeginEditing = YES;
    DWUserInfoViewModel *email = [DWUserInfoViewModel userInforViewModelWithTitle:@"邮箱" text:dict[@"email"] idStr:nil editType:MeEditTypeEmail];
    email.shouldBeginEditing = YES;
    DWUserInfoViewModel *major = [DWUserInfoViewModel userInforViewModelWithTitle:@"专业" text:dict[@"major"][@"majorName"] idStr:nil editType:MeEditTypeProfession];
    DWUserInfoViewModel *degree = [DWUserInfoViewModel userInforViewModelWithTitle:@"学历" text:dict[@"education"][@"educationName"] idStr:nil editType:MeEditTypeDegree];
    DWUserInfoViewModel *identity = [DWUserInfoViewModel userInforViewModelWithTitle:@"职称" text:dict[@"title"][@"titleName"] idStr:nil editType:MeEditTypeIdentity];
    DWUserInfoViewModel *college = [DWUserInfoViewModel userInforViewModelWithTitle:@"学校" text:dict[@"college"][@"collegeName"] idStr:nil editType:MeEditTypeSchool];
    DWUserInfoViewModel *telNumber = [DWUserInfoViewModel userInforViewModelWithTitle:@"电话" text:dict[@"telNo"] idStr:nil editType:MeEditTypeTelNum];
    telNumber.shouldBeginEditing = YES;
    DWUserInfoViewModel *province = [DWUserInfoViewModel userInforViewModelWithTitle:@"省份" text:dict[@"province"][@"provinceName"] idStr:nil editType:MeEditTypeProvice];
    DWUserInfoViewModel *city = [DWUserInfoViewModel userInforViewModelWithTitle:@"城市" text:dict[@"city"][@"cityName"] idStr:nil editType:MeEditTypeCity];
    return @[userName,email,major,degree,identity,college,telNumber,province,city];
   
}
- (RACSignal *)meItemsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"me.plist" ofType:nil];
        NSArray *items = [DWMeItem objectArrayWithFile:filePath];
        [subscriber sendNext:items];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)allInstructionsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSArray *dictArr = [[SXQDBManager sharedManager] meAllInstructions];
        NSArray *modelArr =  [SXQExpInstruction objectArrayWithKeyValuesArray:dictArr];
        [subscriber sendNext:modelArr];
        [subscriber sendCompleted];
        return nil;
    }];
}
- (RACSignal *)signUpModelsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"signup.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//        DWSignUpGroup *group = [DWSignUpGroup objectWithKeyValues:dict];
//        [subscriber sendNext:[self groupsWithSignUpGrop:group]];
//        [subscriber sendCompleted];
        return nil;
    }];
}
@end
