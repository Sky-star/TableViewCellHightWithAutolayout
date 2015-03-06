//
//  TestTableViewCell.m
//  TableViewHightDemo
//
//  Created by Sky on 15/1/29.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

#pragma mark  创建tableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *userinfo = @"clientCell";
    TestTableViewCell *cell=nil; //= [tableView dequeueReusableCellWithIdentifier:userinfo];
    if (cell == nil)
    {
        //从XIB文件中创建自定义的Cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
