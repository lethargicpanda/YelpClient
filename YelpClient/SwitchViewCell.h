//
//  SwitchViewCell.h
//  YelpClient
//
//  Created by Thomas Ezan on 3/24/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;
@property (strong, nonatomic) NSUserDefaults *filterDefaults;

@end
