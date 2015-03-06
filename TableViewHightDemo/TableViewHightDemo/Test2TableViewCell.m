//
//  Test2TableViewCell.m
//  TableViewHightDemo
//
//  Created by Sky on 15/2/2.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "Test2TableViewCell.h"
#import "UIView+AutoLayout.h"

@interface Test2TableViewCell ()

//对于每个cell 用一个bool值去标识是否已设置约束
@property (nonatomic, assign) BOOL didSetupConstraints;


@end

@implementation Test2TableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.bodyLabel];
    }
    return self;
}

-(void)updateConstraints
{
    //如果未设置约束 则进行约束
    if (!self.didSetupConstraints)
    {
        [self.headImageView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:7];
        [self.headImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
        [self.headImageView autoSetDimension:ALDimensionHeight toSize:45];
        [self.headImageView autoSetDimension:ALDimensionWidth toSize:51];
        
        [self.bodyLabel autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.headImageView withOffset:19];
        [self.bodyLabel autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:20];
        [self.bodyLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
        [self.bodyLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:11];
        
        self.didSetupConstraints = YES;

    }
    
    //这句一定要写， 不写会崩
    [super updateConstraints];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.

    self.bodyLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.bodyLabel.frame);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Property Accessor
-(UIImageView *)headImageView
{
    if (!_headImageView)
    {
        _headImageView=[[UIImageView alloc]initForAutoLayout];
        _headImageView.backgroundColor=[UIColor orangeColor];
        _headImageView.image=[UIImage imageNamed:@"10_5"];
    }
    return _headImageView;
}

-(UILabel *)bodyLabel
{
    if (!_bodyLabel)
    {
        _bodyLabel=[[UILabel alloc]initForAutoLayout];
        _bodyLabel.backgroundColor=[UIColor blueColor];
        _bodyLabel.textColor=[UIColor whiteColor];
        //以下几个属性必须设置
        _bodyLabel.numberOfLines=0;
        _bodyLabel.textAlignment=NSTextAlignmentLeft;
        [_bodyLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    }
    return _bodyLabel;
}

@end
