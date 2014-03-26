//
//  FilterViewController.h
//  YelpClient
//
//  Created by Thomas Ezan on 3/23/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

@optional
- (void)addItemViewController:(FilterViewController *)controller didFinishEnteringItem:(NSDictionary *)filters;
@end

@interface FilterViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, weak) id <FilterViewControllerDelegate> delegate;

@end
