//
//  DWReagentDetailController.m
//  实验助手
//
//  Created by sxq on 15/11/27.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SXQExpReagent.h"
#import "DWReagentDetailController.h"

@interface DWReagentDetailController ()
@property (nonatomic,weak) IBOutlet UILabel *reagentNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *chemicalLabel;
@property (nonatomic,weak) IBOutlet UILabel *supplierLabel;
@property (nonatomic,weak) IBOutlet UILabel *firstLabel;
@property (nonatomic,weak) IBOutlet UILabel *secondeLabel;
@property (nonatomic,weak) IBOutlet UILabel *placeLabel;
@property (nonatomic,weak) IBOutlet UILabel *productNumLabel;
@property (nonatomic,weak) IBOutlet UILabel *createLabel;
@property (nonatomic,weak) IBOutlet UILabel *guigeLabel;
@property (nonatomic,weak) IBOutlet UILabel *casnumLabel;
@property (nonatomic,weak) IBOutlet UILabel *demonstrationLabel;
@property (nonatomic,strong) SXQExpReagent *reagent;
@property (nonatomic,strong) id<DWInstructionService> service;
@end

@implementation DWReagentDetailController
- (instancetype)initWithExpReagent:(SXQExpReagent *)reagent service:(id<DWInstructionService>)service
{
    if (self = [super init]) {
        _reagent = reagent;
        _service = service;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_loadData];
}
- (void)p_loadData
{
    [[self.service reagentSignalWithReagentModel:self.reagent]
    subscribeNext:^(id x) {
        
    }];
    
} @end
