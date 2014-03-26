//
//  ViewController.m
//  YelpClient
//
//  Created by Thomas Ezan on 3/20/14.
//  Copyright (c) 2014 Thomas Ezan. All rights reserved.
//

#import "SearchViewController.h"
#import "Restaurant.h"
#import "RestaurantCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "FilterViewController.h"


@interface SearchViewController ()

@property (atomic, strong) NSArray *restaurantArray;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSString *searchTerm;
@property (strong, nonatomic) NSUserDefaults *filterDefaults;

@end

@implementation SearchViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init tableview
    self.restaurantTableView.dataSource = self;
    self.restaurantTableView.delegate = self;

    // Set filter button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(didTouchFilterButton)];

    // Init searchbar
    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    // Init custom UITableCell
    UINib *nib = [UINib nibWithNibName:@"RestaurantCell" bundle:nil];
    [self.restaurantTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    
    // Get the user default for the filters
    self.filterDefaults = [NSUserDefaults standardUserDefaults];
    
    // Load the data from Yelp api
    [self refreshData];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.restaurantArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // Get cell
    RestaurantCell *cell = [self.restaurantTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Get the current restaurant for the cell
    Restaurant *currentRestaurant = self.restaurantArray[indexPath.row];
    
    // Populate the cell's labels with the info for currentRestaurant
    cell.restaurantName.text = currentRestaurant.name;
    cell.distanceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f mi", currentRestaurant.distance];
    cell.priceLabel.text = @"$$"; // TODO
    cell.reviewCountLabel.text = [[NSString alloc] initWithFormat:@"%i reviews", currentRestaurant.reviewCount];
    cell.addressLabel.text = [currentRestaurant getFormatedAddress];
    cell.categoryLabel.text = @""; // TODO
    
    // Load rating image
    [cell.ratingImage setImageWithURL:[NSURL URLWithString:currentRestaurant.ratingImgUrl] placeholderImage:[UIImage imageNamed:@"ratingImagePlaceholder"]];
    
    // Load restaurant photo
    [cell.restaurantPhoto setImageWithURL:[NSURL URLWithString:currentRestaurant.photoUrl] placeholderImage:[UIImage imageNamed:@"photoPlaceholder"]];

    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //Get the name of the current restaurant for this row
    NSString *currentRestaurantName = ((Restaurant *)self.restaurantArray[indexPath.row]).name;
    
    // Get the font for the Restaurant name label
    UIFont *restaurantLabelFont = [UIFont systemFontOfSize:17.0];
    
    // Compute the size of the label
    CGRect rectForRestaurantName = [currentRestaurantName boundingRectWithSize:CGSizeMake(139, CGFLOAT_MAX)
                                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                                 attributes:@{NSFontAttributeName:restaurantLabelFont}
                                                                    context:nil];
    
    // Compute the height of the row
    return 84 + rectForRestaurantName.size.height;
}


- (void)didTouchFilterButton {
    FilterViewController *filterController = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    [self.navigationController pushViewController:filterController animated:YES];
}




#pragma mark - Network communication
- (void) refreshData{
    
    NSLog([self isNetworkAvailable] ? @"Network Available!" : @"Network not Available!");
    
    if (![self isNetworkAvailable]) {
        return;
    }
    
    // Default to restaurant if empty
    if ([self.searchTerm isEqualToString:@""] || self.searchTerm == nil) {
        self.searchTerm = @"Restaurant";
        self.searchBar.text = self.searchTerm;
        
    }
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://api.yelp.com/business_review_search?term=%@&lat=37.788022&long=-122.399797&radius=10&limit=30&ywsid=kGcwPFgr_rcLlbjMh0pRRA",self.searchTerm];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *restaurantDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.restaurantArray = [Restaurant restaurantWithDictionnary:restaurantDictionary];
        app.networkActivityIndicatorVisible = NO;
        [self.restaurantTableView reloadData];
        
    }];
    
}

- (BOOL)isNetworkAvailable{
    CFNetDiagnosticRef dReference;
    dReference = CFNetDiagnosticCreateWithURL (NULL, (__bridge CFURLRef)[NSURL URLWithString:@"api.yelp.com"]);
    
    CFNetDiagnosticStatus status;
    status = CFNetDiagnosticCopyNetworkStatusPassively (dReference, NULL);
    
    CFRelease (dReference);
    
    if ( status == kCFNetDiagnosticConnectionUp )
    {
        NSLog (@"Connection is Available");
        return YES;
    }
    else
    {
        NSLog (@"Connection is not available");
        return NO;
    }
}

#pragma mark - UISearchViewDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // Set the new search term
    self.searchTerm = searchBar.text;
    // Hide the keyboard
    [self.searchBar resignFirstResponder];
    
    // Reload the data in the tableview
    [self refreshData];
}

@end
