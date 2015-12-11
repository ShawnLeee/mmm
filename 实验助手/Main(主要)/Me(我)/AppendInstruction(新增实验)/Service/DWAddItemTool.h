//
//  DWAddItemTool.h
//  实验助手
//
//  Created by sxq on 15/12/11.
//  Copyright © 2015年 SXQ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,DWAddItemType)
{
    DWAddItemTypeReagent = 1,
    DWAddItemTypeConsumable = 2,
    DWAddItemTypeEquipment = 3,
};
typedef void (^CompletionHandler)(id result);
@protocol DWAddItemTool <NSObject>
- (void)showFirstPickerWithOrigin:(id)origin handler:(CompletionHandler)handler;
- (void)showSecondPickerWithOrigin:(id)origin levelOne:(NSString *)levelOneID handler:(CompletionHandler)handler;
- (void)showReagentWithOrigin:(id)origin levelOne:(NSString *)levelOneID levelTwo:(NSString *)levelTwoID handler:(CompletionHandler)handler;
- (void)showSupplierWithOrigin:(id)origin itemType:(DWAddItemType)itemType itemID:(NSString *)itemID handler:(CompletionHandler)handler;
@end
