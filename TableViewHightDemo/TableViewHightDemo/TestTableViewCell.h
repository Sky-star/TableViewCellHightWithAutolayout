//
//  TestTableViewCell.h
//  TableViewHightDemo
//
//  Created by Sky on 15/1/29.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
