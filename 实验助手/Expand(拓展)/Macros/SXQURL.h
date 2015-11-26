//
//  SXQURL.h
//  实验助手
//
//  Created by sxq on 15/9/11.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//
//hualang.wicpnet:8090
#ifndef _____SXQURL_h
#define _____SXQURL_h
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,LABResponseType)
{
    LABResponseTypeFailure = 0,
    LABResponseTypeSuccess = 1,
};

////////////////////////////////////////////实验部分////////////////////////////////////
//获取实验或说明书下所有的实验步骤
#define ExperimentStepURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getAllProcessExceptComplete?userID=4028c681494b994701494b99aba50000"
//附近的试剂交换
#define AdjacentReagentURL @"http://hualang.wicp.net:8090/LabAssistant/map/around"
//正在进行的实验
#define DoingExpURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getDoing?userID=4028c681494b994701494b99aba50000"
//已完成的实验
#define DoneExpURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getComplete?userID=4028c681494b994701494b99aba50000"
// 获取实验所需的试剂
#define ReagentListURL @"http://hualang.wicp.net:8090/LabAssistant/lab/allReagents"
//获取实验试剂及对应的厂商
#define ReagentSupplierURL @"http://hualang.wicp.net:8090/LabAssistant/lab/reagentAndSupplier"
//获取实验试剂及对应的用量
#define ReagentPerAmountURL @"http://hualang.wicp.net:8090/LabAssistant/lab/perAmount"
//根据输入的查询条件筛选实验说明书
#define SearchInstruction @"http://hualang.wicp.net:8090/LabAssistant/lab/getInstructionsByFilter"
//上传每步实验步骤所拍的照片
#define UploadExpProcessImgsURL @"http://hualang.wicp.net:8090/LabAssistant/upload/perExpProcessImgs"
//同步实验部分
#define SynExperimentURL @"http://hualang.wicp.net:8090/LabAssistant/pdf"
//实验报告列表
#define ExperimentReportListURL @"http://hualang.wicp.net:8090/LabAssistant/pdf/pdfList"
#define ExperimentReportDownloadURL @"http://hualang.wicp.net:8090/LabAssistant/pdf/downloadPdf"
//下载实验报告
#define CommentListURL @"http://hualang.wicp.net:8090/LabAssistant/lab/reviewOptional"
////////////////////////////////////////////实验部分////////////////////////////////////

//////////////////////////////说明书//////////////////////////////////////////////////////
#define InstructionMainURL @"http://hualang.wicp.net:8090/LabAssistant/expCategory/getAllCategory"
//所有说明书
#define AllExpURL @"http://hualang.wicp.net:8090/LabAssistant/expCategory/allExpCategory"
//二级分类
#define SubExpURL @"http://hualang.wicp.net:8090/LabAssistant/expCategory/getSubCategoryByPID"
//说明书列表
#define InstructionListURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getInstructionsBySubCategoryID"
//说明书下载
#define DownloadInstructionURL @"http://hualang.wicp.net:8090/LabAssistant/lab/downloadInstruction"
//说明书详情
#define InstructionDetailURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getInstructionDetail"
//热门说明书
#define HotInstructionsURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getHotInstructions"
//搜索说明书
#define SearchInstructionURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getInstructionsByFilter"
//评论详情
#define CommentDetailURL @"http://hualang.wicp.net:8090/LabAssistant/lab/reviewDetail"
//评论
#define CommentURL @"http://hualang.wicp.net:8090/LabAssistant/lab/responseReview"
//////////////////////////////说明书//////////////////////////////////////////////////////

#define SupplierURL @"http://hualang.wicp.net:8090/LabAssistant/sync/pullCommon"
//////////////////////////////登录/注册//////////////////////////////////////////////////////
#define LoginURL @"http://hualang.wicp.net:8090/LabAssistant/login"
#define SignUpURL @"http://hualang.wicp.net:8090/LabAssistant/register"
//////////////////////////////登录/注册//////////////////////////////////////////////////////
#define ScheduleURL @"http://hualang.wicp.net:8090/LabAssistant/lab/getMyExpPlan"
#define DeleteScheduleURL @"http://hualang.wicp.net:8090/LabAssistant/lab/deleteMyExpPlan"
#define AddScheduleURL @"http://hualang.wicp.net:8090/LabAssistant/lab/setMyExpPlan"
//资讯
#define NewsURL @"http://hualang.wicp.net:8090/LabAssistant/grabNews"
#define ProvinceURL @"http://hualang.wicp.net:8090/LabAssistant/myInfo/provinceAndCity"
//职称列表
#define IdentityURL @"http://hualang.wicp.net:8090/LabAssistant/myInfo/titles"
//学历列表
#define DegreeURL @"http://hualang.wicp.net:8090/LabAssistant/myInfo/educations"
//学校列表
#define SchoolURL @"http://hualang.wicp.net:8090/LabAssistant/myInfo/colleges"
#define ProfessionURL @"http://hualang.wicp.net:8090/LabAssistant/myInfo/educations"
#define UserInfoURL @"http://172.18.1.55:8080/LabAssistant/myInfo/basic"
#endif
