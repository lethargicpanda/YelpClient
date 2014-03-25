//
//  FilterViewController.m
//  YelpClient
//
//  Created by Thomas Ezan on 3/23/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "FilterViewController.h"
#import "SegmentedViewCell.h"
#import "SwitchViewCell.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (atomic, strong) NSArray *settingsArray;
@property (nonatomic, strong)NSUserDefaults *filterDefaults;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self.filterDefaults = [NSUserDefaults standardUserDefaults];
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.settingsArray = [NSMutableArray arrayWithObjects:
                              @{
                                @"name":@"Price",
                                @"type":@"segmented",
                                @"list":@[@"$",@"$$",@"$$$",@"$$$$"]
                                },
                              @{
                                @"name":@"Most Popular",
                                @"type":@"switches",
                                @"list":@[@"Open Now",@"Hot & New",@"Offering a Deal",@"Delivery"]
                                },
                              @{
                                @"name":@"Distance",
                                @"type":@"expandable",
                                @"list":@[@"Auto",@"2 blocks",@"6 blocks",@"1 mile",@"5 miles"]
                                },
                              @{
                                @"name":@"Sort By",
                                @"type":@"expandable",
                                @"list":@[@"Best Match",@"Distance",@"Rating",@"Most Reviewed"]
                                },
                              @{
                                @"name":@"General Features",
                                @"type":@"expandable",
                                @"list":@[@"Take-out",@"Good for Groups",@"Has TV",@"Accepts Credit Cards",@"Wheelchair Accessible",@"Full Bar",@"Beer & Wine only",@"Happy Hour",@"Free Wi-Fi",@"Paid Wi-fi"]
                                },
                              nil
                              ];
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.filterTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma UITableViewDatasourceView
- (NSInteger)numberOfSectionsInTableView:(UITableView *) tableView{
    
    NSLog(@"numberOfSectionsInTable: %d", self.settingsArray.count);
    return self.settingsArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{    
    return [self.settingsArray[section] objectForKey:@"name"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *sectionDictonnary = [self.settingsArray objectAtIndex:section];
    
    NSString *type = [sectionDictonnary objectForKey:@"type"];
    
    if ([type isEqualToString:@"segmented"] || [type isEqualToString:@"expandable"]) {
        return 1;
    } else {
        return [[sectionDictonnary objectForKey:@"list"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *type = [self.settingsArray[indexPath.section] objectForKey:@"type"];
    NSArray *optionList = [self.settingsArray[indexPath.section] objectForKey:@"list"];
    
    
    UITableViewCell *cell;
    
    if ([type isEqualToString:@"segmented"]) {
        static NSString *cellIdentifier = @"SegmentedCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SegmentedViewCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
        
    } else if ([type isEqualToString:@"switches"]){
        static NSString *cellIdentifier = @"SwitchCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        self.filterDefaults = [NSUserDefaults standardUserDefaults];
        ((SwitchViewCell*)cell).cellSwitch.on = [self.filterDefaults boolForKey:optionList[indexPath.row]];

        
        ((SwitchViewCell*)cell).cellLabel.text = optionList[indexPath.row];
        
    } else {
        static NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }

            cell.textLabel.text = optionList[indexPath.row];
    }

    return cell;
    
}


@end
