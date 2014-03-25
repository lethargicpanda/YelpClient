//
//  SwitchViewCell.m
//  YelpClient
//
//  Created by Thomas Ezan on 3/24/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "SwitchViewCell.h"

@implementation SwitchViewCell

@synthesize cellLabel = _cellLabel;
@synthesize cellSwitch = _cellSwitch;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.cellSwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setState:(id)sender{
    BOOL state = [self.cellSwitch isOn];
    NSLog(@"%hhd",state);
    [self.filterDefaults setBool:state forKey:self.cellLabel.text];
}

@end
