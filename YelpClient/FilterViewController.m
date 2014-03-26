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

@property (nonatomic, assign) BOOL distanceCategoryExpanded;
@property (nonatomic, assign) BOOL sortbyCategoryExpanded;
@property (nonatomic, assign) BOOL generalFeaturesCategoryExpanded;

@property (nonatomic, assign) int sortByParam;
@property (nonatomic, assign) int distanceRadius;
@property (nonatomic, assign) BOOL offeringADeal;

@property (nonatomic, strong) NSDictionary *filterParameters;

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
                                @"list":@[@"Best Match",@"Distance",@"Rating"]
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
    
    // Init tableview
    self.filterTableView.dataSource = self;
    self.filterTableView.delegate = self;
    
    // Init custom UITableCell
    UINib *segmentedViewCellNib = [UINib nibWithNibName:@"SegmentedViewCell" bundle:nil];
    [self.filterTableView registerNib:segmentedViewCellNib forCellReuseIdentifier:@"SegmentedViewCell"];
    
    UINib *switchViewCellNib = [UINib nibWithNibName:@"SwitchViewCell" bundle:nil];
    [self.filterTableView registerNib:switchViewCellNib forCellReuseIdentifier:@"SwitchViewCell"];
    
    // Init save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onSaveButton:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma UITableViewDatasourceView
- (NSInteger)numberOfSectionsInTableView:(UITableView *) tableView{
    return self.settingsArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{    
    return [self.settingsArray[section] objectForKey:@"name"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *sectionDictonnary = [self.settingsArray objectAtIndex:section];
    
    NSString *type = [sectionDictonnary objectForKey:@"type"];
    
    if ([type isEqualToString:@"segmented"] || [type isEqualToString:@"expandable"]) {
        
        // Implement expendable section
        if (section==2 && self.distanceCategoryExpanded) {
           return ((NSArray*)[self.settingsArray[2] objectForKey:@"list"]).count;
        } else if (section==3 && self.sortbyCategoryExpanded) {
            return((NSArray*)[self.settingsArray[3] objectForKey:@"list"]).count;
        } else if (section==4 && self.generalFeaturesCategoryExpanded) {
            return ((NSArray*)[self.settingsArray[4] objectForKey:@"list"]).count;
        } else {
          return 1;
        }
        
    } else {
        return [[sectionDictonnary objectForKey:@"list"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Get current 'type' and 'list' for the cell
    NSString *type = [self.settingsArray[indexPath.section] objectForKey:@"type"];
    NSArray *optionList = [self.settingsArray[indexPath.section] objectForKey:@"list"];
    
    
    UITableViewCell *cell;
    
    if ([type isEqualToString:@"segmented"]) {
        // Show SegmentedViewCell
        cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"SegmentedViewCell" forIndexPath:indexPath];

    } else if ([type isEqualToString:@"switches"]){
        // Show SwitchViewCell
        cell = [self.filterTableView dequeueReusableCellWithIdentifier:@"SwitchViewCell" forIndexPath:indexPath];
        
        self.filterDefaults = [NSUserDefaults standardUserDefaults];
        ((SwitchViewCell*)cell).cellSwitch.on = [self.filterDefaults boolForKey:optionList[indexPath.row]];
        ((SwitchViewCell*)cell).cellLabel.text = optionList[indexPath.row];
        
        ((SwitchViewCell*)cell).cellSwitch.tag = (indexPath.section*10) + (indexPath.row);
        [((SwitchViewCell*)cell).cellSwitch addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
        
    } else {
        // Show regular cell
        static NSString *CellIdentifier = @"Cell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }

        cell.textLabel.text = optionList[indexPath.row];
    }

    return cell;
    
}

#pragma mark -  UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Implement expandable list
    if (indexPath.section==2){
        self.distanceCategoryExpanded = !self.distanceCategoryExpanded;
    } else if (indexPath.section==3){
        
        if(self.sortbyCategoryExpanded){
            self.sortByParam = indexPath.row;
        }
        
        self.sortbyCategoryExpanded = !self.sortbyCategoryExpanded;
        
    } else if (indexPath.section==4){
        self.generalFeaturesCategoryExpanded = !self.generalFeaturesCategoryExpanded;
    }
    
    [self.filterTableView reloadData];
    
}

- (void)setState:(id)sender{
    BOOL state = [(UISwitch*)sender isOn];

    // Saving "offering a deal" filter
    if ((((UIControl *)sender).tag)==12){
        self.offeringADeal = state;
    }
        
//    NSString* switchFilter = ((NSArray *)[self.settingsArray[1] objectForKey:@"list"])[((SwitchViewCell*)sender).tag];
//    [self.filterDefaults setBool:state forKey:switchFilter];
}


- (void)onSaveButton:(id)sender {
    
    
    NSString *offeringADealString;
    if(self.offeringADeal){
        offeringADealString = @"true";
    } else {
        offeringADealString = @"false";
    }
    
    [self.delegate addItemViewController:self didFinishEnteringItem:@{@"sort": [NSNumber numberWithInt:self.sortByParam], @"radius_filter": [NSNumber numberWithInt:500], @"deals_filter": offeringADealString}];
    
    
//    // Save "Sort By"
//    [self.filterDefaults setInteger:self.sortByParam forKey:@"sort"];
//    // Save radius
//    [self.filterDefaults setInteger:500 forKey:@"radius_filter"]; // TODO
//    // Save offering a deal
//    [self.filterDefaults setBool:self.offeringADeal forKey:@"deals_filter"];
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
