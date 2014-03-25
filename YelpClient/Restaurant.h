//
//  Restaurant.h
//  YelpClient
//
//  Created by Thomas Ezan on 3/22/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
+ (NSArray *)restaurantWithDictionnary:(NSDictionary *)dictionnary;
- (NSString *)getFormatedAddress;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *yelpId;
@property (nonatomic, assign) BOOL isClosed;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *mobileUrl;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, retain) NSString *stateCode;
@property (nonatomic, retain) NSString *address1;
@property (nonatomic, retain) NSString *address2;
@property (nonatomic, retain) NSString *address3;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *photoUrl;
@property (nonatomic, assign) double distance;
@property (nonatomic, retain) NSString *ratingImgUrl;


@end
