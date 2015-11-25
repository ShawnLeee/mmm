//
//  DWMeInstructionCell.m
//  实验助手
//
//  Created by sxq on 15/11/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "SXQExpInstruction.h"
#import "DWMeInstructionCell.h"
@interface DWMeInstructionCell ()
@property (nonatomic,weak) IBOutlet UILabel *instructionNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *supplierNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *productNumLabel;
@end
@implementation DWMeInstructionCell
- (void)setInstruction:(SXQExpInstruction *)instruction
{
    _instruction = instruction;
    self.instructionNameLabel.text = instruction.experimentName;
    self.supplierNameLabel.text = instruction.supplierName;
    self.productNumLabel.text = instruction.productNum;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
