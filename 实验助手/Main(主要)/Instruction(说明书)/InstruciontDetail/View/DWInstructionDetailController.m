//
//  DWInstructionDetailController.m
//  实验助手
//
//  Created by sxq on 15/11/16.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWInstructionDetailController+DataSource.h"
#import "DWGroup.h"
#import "DWInstructionDetailController.h"
#import "DWInstructionDetailHeader.h"
#import "DWInstructionDetailCell.h"
#import "DWInstructionDisclosure.h"
#import "DWInstructionServiceImpl.h"
@interface DWInstructionDetailController ()
@property (nonatomic,strong) id<DWInstructionService> service;
@end

@implementation DWInstructionDetailController

static NSString * const reuseIdentifier = @"cell";
- (id<DWInstructionService>)service
{
    if(!_service)
    {
        _service = [[DWInstructionServiceImpl alloc] initWithNavigationController:self.navigationController];
    }
    return _service;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionDetailCell class]) bundle:nil] forCellWithReuseIdentifier: NSStringFromClass([DWInstructionDetailCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DWInstructionDisclosure class]) bundle:nil] forCellWithReuseIdentifier: NSStringFromClass([DWInstructionDisclosure class])];
    [self p_loadData];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DWGroup *group = self.groups[indexPath.section];
    id viewModel = group.items[indexPath.row];
    [self.service pushViewModel:viewModel];
}
@end
