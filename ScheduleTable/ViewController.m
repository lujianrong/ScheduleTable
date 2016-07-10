//
//  ViewController.m
//  ScheduleTable
//
//  Created by lujianrong on 16/7/10.
//  Copyright © 2016年 LJR. All rights reserved.
//

#import "ViewController.h"
#import "ScheduleTable/ScheduleTable.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)loadView {
    self.view =  [[ScheduleTable alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

@end
