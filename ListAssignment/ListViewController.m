//
//  ListViewController.m
//  ListAssignment
//
//  Created by pooja on 30/11/2017.
//  Copyright © 2017 pooja. All rights reserved.
//

#import "ListViewController.h"
#import "APIManeger.h"
#import "TableViewCell.h"

#define reuseIdentifier @"cellIdentifier"

@interface ListViewController ()
{
    UIActivityIndicatorView *indicator;
}
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.estimatedRowHeight = 100;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSelection:) name:@"updateSelection" object:nil];
    
    indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [indicator setCenter:self.view.center];
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.tableView addSubview:indicator];
    [indicator startAnimating];
    
    [[APIManeger getAPIManager] fetchData:@"https://hn.algolia.com/api/v1/search_by_date?tags=story" done:^(id data) {
       
        [self setData:[data objectForKey:@"hits"]];
    }];
}

-(void)setData:(NSArray *)arr
{
    self.dataArr = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in arr)
    {
        NSMutableDictionary *finalDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        [finalDict setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
        [self.dataArr addObject:finalDict];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [indicator stopAnimating];
        [indicator removeFromSuperview];
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *data = [self.dataArr objectAtIndex:indexPath.row];
    // Configure the cell...
    [cell setup:data];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
    //return 100;
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = [self updateData:indexPath];
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectCell:data];
}

-(void)updateSelection:(NSNotification *)notif
{
    TableViewCell *cell = notif.object;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self updateData:indexPath];
}

-(NSDictionary *)updateData:(NSIndexPath *)indexPath
{
    NSMutableDictionary *data = [self.dataArr objectAtIndex:indexPath.row];
    BOOL isSelected = [[data objectForKey:@"selected"] boolValue];
    [data setObject:[NSNumber numberWithBool:!isSelected] forKey:@"selected"];
    [self showCount];
    return data;
}

-(void)showCount
{
    NSInteger count = 0;
    for (NSDictionary *dict in self.dataArr)
    {
        BOOL isSelected = [[dict objectForKey:@"selected"] boolValue];
        if (isSelected) count++;
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"%ld", count];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
