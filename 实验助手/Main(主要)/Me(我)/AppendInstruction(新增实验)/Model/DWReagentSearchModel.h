//
//  DWReagentSearchModel.h
//  实验助手
//
//  Created by sxq on 15/12/14.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWReagentSearchModel : NSObject
@property (nonatomic,copy) NSString *levelOneSortID;
@property (nonatomic,copy) NSString *levelOneSortName;
@property (nonatomic,copy) NSString *levelTwoSortID;
@property (nonatomic,copy) NSString *levelTwoSortName;
@property (nonatomic,copy) NSString *reagentName;
@property (nonatomic,copy) NSString *reagentID;
@property (nonatomic,strong) NSArray *suppliers;
@end
