//
//  SXQReportHelperImpl.m
//  实验助手
//
//  Created by sxq on 15/11/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import "SXQHttpTool.h"
#import "SXQReportHelperImpl.h"
#import "SXQReportItem.h"
#import <MJExtension/MJExtension.h>
#import "SXQReportViewModel.h"
@interface SXQReportHelperImpl ()
@end
@implementation SXQReportHelperImpl
- (RACSignal *)reportListSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [SXQHttpTool getWithURL:ExperimentReportListURL params:nil success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSArray *resultArray = [SXQReportItem objectArrayWithKeyValuesArray:json[@"data"]];
                [self processReportItem:resultArray];
               [subscriber sendNext:resultArray];
               [subscriber sendCompleted];
            }else
            {
                [subscriber sendError:nil];
            }
            
        } failure:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}
- (RACSignal *)downloadReportSignalWithReportItem:(SXQReportItem *)reportItem
{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *params = @{@"myExpID" : reportItem.myExpID};
        [SXQHttpTool getWithURL:ExperimentReportDownloadURL params:params success:^(id json) {
            if ([json[@"code"] isEqualToString:@"1"]) {
                NSString *pdfStr = json[@"data"][@"pdfStream"];
                NSData *pdfData = [[NSData alloc] initWithBase64EncodedString:pdfStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
                [self savePdf:pdfData name:reportItem.pdfName];
               [subscriber sendNext:@(YES)];
               [subscriber sendCompleted];
            }else
            {
               [subscriber sendNext:@(NO)];
            }
        } failure:^(NSError *error) {
               [subscriber sendNext:@(NO)];
        }];
        return nil;
    }];
    return nil;
}
- (void)savePdf:(NSData *)pdfData name:(NSString *)name
{
    NSString *pdfName = [self getDBPathPDf:name];
    [pdfData writeToFile:pdfName atomically:YES];
}


-(NSString *)getDBPathPDf:(NSString *)PdfName {
    NSString *pdfFile = [PdfName stringByAppendingString:@".pdf"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:pdfFile];
}
- (void)processReportItem:(NSArray *)reportItemArray
{
    [reportItemArray enumerateObjectsUsingBlock:^(SXQReportItem *reportItem, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL fileExist = [self isPdfFileExist:reportItem.pdfName];
        reportItem.downloaded = fileExist;
    }];
}
- (BOOL)isPdfFileExist:(NSString *)name
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[self getDBPathPDf:name]];
}
@end
