//
//  RestaurantCell.m
//  YelpClient
//
//  Created by Thomas Ezan on 3/22/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "RestaurantCell.h"

@implementation RestaurantCell

@synthesize restaurantPhoto = _restaurantPhoto;
@synthesize restaurantName = _restaurantName;
@synthesize ratingImage = _ratingImage;
@synthesize reviewLabel = _reviewLabel;
@synthesize priceLabel = _priceLabel;
@synthesize addressLabel = _addressLabel;
@synthesize categoryLabel = _categoryLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
