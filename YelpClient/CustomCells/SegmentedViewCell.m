//
//  SegmentedViewCell.m
//  YelpClient
//
//  Created by Thomas Ezan on 3/23/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "SegmentedViewCell.h"
//
//@protocol didSelectSegment <NSObject>
//
//@optional
//-(view) didSelectSegment:(NSInteger)segement;
//
//@end

@implementation SegmentedViewCell

@synthesize segmentedControl = _segmentedControl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSArray *)data
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
