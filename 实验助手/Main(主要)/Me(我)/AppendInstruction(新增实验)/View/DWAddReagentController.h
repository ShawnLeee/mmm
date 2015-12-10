//
//  DWAddReagentController.h
//  实验助手
//
//  Created by sxq on 15/12/10.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@class DWAddReagentViewModel;
#import <UIKit/UIKit.h>

@interface DWAddReagentController : UITableViewController
@property (nonatomic,copy) void (^doneBlock)(DWAddReagentViewModel *reagentViewModel);
@property (nonatomic,copy) NSString *instrucitonID;
@end
