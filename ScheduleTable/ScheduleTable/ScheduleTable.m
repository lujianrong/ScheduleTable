//
//  ScheduleTable.m
//  ScheduleTable
//
//  Created by lujianrong on 16/7/10.
//  Copyright © 2016年 LJR. All rights reserved.
//

#import "ScheduleTable.h"

static CGFloat const rowHeight = 80.0;
static CGFloat const leftTableViewW = 70.0;
@interface ScheduleTable()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation ScheduleTable
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftTableViewW, self.frame.size.height)];
        _leftTableView.rowHeight                      = rowHeight;
        _leftTableView.delegate                       = self;
        _leftTableView.dataSource                     = self;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.showsVerticalScrollIndicator   = NO;
    }
    return _leftTableView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(leftTableViewW, 0, self.frame.size.width- leftTableViewW, self.frame.size.height)];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces                        = NO;
        _scrollView.contentSize = self.rightTableView.frame.size;
        [_scrollView addSubview:_rightTableView];
    }
    return _scrollView;
}
- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 600, self.leftTableView.frame.size.height)];
        _rightTableView.rowHeight = rowHeight;
        _rightTableView.delegate                       = self;
        _rightTableView.dataSource                     = self;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.showsVerticalScrollIndicator   = NO;
    }
    return _rightTableView;
}
- (void)loadUI {
    [self addSubview:self.leftTableView];
    [self addSubview:self.scrollView];
}
#pragma mark
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *defaultCellID = @"defaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCellID];
    if (!cell) {
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:defaultCellID];
    }
    if ([tableView isEqual:_leftTableView]) {
        cell.backgroundColor = [UIColor grayColor];
        cell.textLabel.text = [NSString stringWithFormat:@"左%ld", indexPath.row+1];
    } else {
        cell.backgroundColor = [UIColor purpleColor];
        cell.textLabel.text = [NSString stringWithFormat:@"右边-----> %ld", indexPath.row+1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    if ([tableView isEqual:_leftTableView]) {
        view.frame = CGRectMake(0, 0, leftTableViewW, 40);
        view.backgroundColor = [UIColor redColor];
    } else {
        view.frame = CGRectMake(leftTableViewW, 0, 600, 40);
        view.backgroundColor = [UIColor blueColor];
    }
    return view;
 }

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_leftTableView]){
        _rightTableView.contentOffset = _leftTableView.contentOffset;
    } else {
        _leftTableView.contentOffset = _rightTableView.contentOffset;
    }
}
@end
