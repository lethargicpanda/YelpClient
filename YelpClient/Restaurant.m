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
    for (id restaurantObject in businessList) {
        Restaurant *currentRestaurant  = [[Restaurant alloc]init];
        currentRestaurant.name = [restaurantObject objectForKey:@"name"];
        currentRestaurant.isClosed = [[restaurantObject objectForKey:@"is_closed"] boolValue];
        currentRestaurant.city = [[restaurantObject objectForKey:@"location"] objectForKey:@"city"];
        currentRestaurant.mobileUrl = [restaurantObject objectForKey:@"mobile_url"];
        currentRestaurant.reviewCount = [[restaurantObject objectForKey:@"review_count"] integerValue];
        currentRestaurant.stateCode = [restaurantObject objectForKey:@"state"];
        currentRestaurant.address1 = [[restaurantObject objectForKey:@"location"] objectForKey:@"cross_streets" ];
//        currentRestaurant.address2 = [movieObject objectForKey:@"address2"];
//        currentRestaurant.address3 = [movieObject objectForKey:@"address3"];
        currentRestaurant.phone = [restaurantObject objectForKey:@"phone"];
        currentRestaurant.photoUrl = [restaurantObject objectForKey:@"image_url"];
        currentRestaurant.distance = [[restaurantObject objectForKey:@"distance"] doubleValue];
        currentRestaurant.ratingImgUrl = [restaurantObject objectForKey:@"rating_img_url"];
        
        [res insertObject:currentRestaurant atIndex:index];
        index = index+1;
    }
    
    return res;
}

- (NSString *)getFormatedAddress{
    return [[NSString alloc] initWithFormat:@"%@, %@", self.address1, self.city];
}

@end
