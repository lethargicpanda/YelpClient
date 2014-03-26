//
//  ViewController.h
//  YelpClient
//
//  Created by Thomas Ezan on 3/20/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewController.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FilterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *restaurantTableView;



@end
