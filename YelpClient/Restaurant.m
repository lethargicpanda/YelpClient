//
//  Restaurant.m
//  YelpClient
//
//  Created by Thomas Ezan on 3/22/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

+ (NSArray *)restaurantWithDictionnary:(NSDictionary *)dictionnary{
    NSDictionary *businessList = [dictionnary objectForKey:@"businesses"];
    
    
    NSLog(@"%i", businessList.count);
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    int index = 0;
    for (id movieObject in businessList) {
        Restaurant *currentRestaurant  = [[Restaurant alloc]init];
        currentRestaurant.name = [movieObject objectForKey:@"name"];
        currentRestaurant.yelpId = [movieObject objectForKey:@"id"];
        currentRestaurant.isClosed = [[movieObject objectForKey:@"is_closed"] boolValue];
        currentRestaurant.city = [movieObject objectForKey:@"city"];
        currentRestaurant.mobileUrl = [movieObject objectForKey:@"mobile_url"];
        currentRestaurant.reviewCount = [[movieObject objectForKey:@"review_count"] integerValue];
        currentRestaurant.stateCode = [movieObject objectForKey:@"state"];
        currentRestaurant.address1 = [movieObject objectForKey:@"address1"];
        currentRestaurant.address2 = [movieObject objectForKey:@"address2"];
        currentRestaurant.address3 = [movieObject objectForKey:@"address3"];
        currentRestaurant.phone = [movieObject objectForKey:@"phone"];
        currentRestaurant.photoUrl = [movieObject objectForKey:@"photo_url"];
        currentRestaurant.distance = [[movieObject objectForKey:@"distance"] doubleValue];
        currentRestaurant.ratingImgUrl = [movieObject objectForKey:@"rating_img_url"];
        
        [res insertObject:currentRestaurant atIndex:index];
        index = index+1;
    }
    
    return res;
}

- (NSString *)getFormatedAddress{
    return [[NSString alloc] initWithFormat:@"%@, %@", self.address1, self.city];
}

@end
