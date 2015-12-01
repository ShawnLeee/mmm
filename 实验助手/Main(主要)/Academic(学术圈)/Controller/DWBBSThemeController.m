//
//  DWBBSThemeController.m
//  实验助手
//
//  Created by sxq on 15/12/1.
//  Copyright © 2015年 SXQ. All rights reserved.
//
#import "DWBBSThemeCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DWBBSModel.h"
#import "DWBBSThemeController.h"

@interface DWBBSThemeController ()
@property (nonatomic,strong) DWBBSModel *bbsModel;
@property (nonatomic,strong) id<DWBBSTool> bbsTool;
@property (nonatomic,strong) NSArray *themes;
@end

@implementation DWBBSThemeController
- (instancetype)initWithBBSModel:(DWBBSModel *)bbsModel bbsTool:(id<DWBBSTool>)bbsTool
{
    if (self = [super init]) {
        _bbsModel = bbsModel;
        _bbsTool = bbsTool;
        _themes = @[];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self p_loadData];
}
- (void)p_setupTableView
{
    self.title = _bbsModel.moduleName;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DWBBSThemeCell class]) bundle:nil] forCellReuseIdentifier: NSStringFromClass([DWBBSThemeCell class])];
}
- (void)p_loadData
{
    @weakify(self)
    [[self.bbsTool themesWithBBSModel:_bbsModel]
    subscribeNext:^(NSArray *themes) {
        @strongify(self)
        self.themes = themes;
        [self.tableView reloadData];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.themes.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DWBBSThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DWBBSThemeCell class]) forIndexPath:indexPath];
    cell.bbsTheme = self.themes[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.bbsTool bbsPushModel:self.themes[indexPath.row]];
}
@end
