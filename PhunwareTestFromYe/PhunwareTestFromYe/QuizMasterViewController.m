//
//  QuizMasterViewController.m
//  PhunwareTestFromYe
//
//  Created by Yukui Ye on 8/30/13.
//  Copyright (c) 2013 Yukui Ye. All rights reserved.
//

#import "QuizMasterViewController.h"

#import "QuizDetailViewController.h"

@interface QuizMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation QuizMasterViewController
@synthesize loadData,dataInfor;



- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURL *url=[NSURL URLWithString:@"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json"];
    //   NSURLRequest *request=[NSURLRequest requestWithURL:url];
    // [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    self.dataInfor = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (QuizDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

/*
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 
 - (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)request
 {
 loadData = [[NSMutableData alloc] init];
 }
 
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)thedata
 {
 [loadData appendData:thedata];
 // NSLog(@"loadData description: %@",[loadData description]);
 }
 
 - (void)connectionDidFinishLoading:(NSURLConnection *)connection
 {
 self.dataInfor = [NSJSONSerialization JSONObjectWithData:loadData options:NSJSONReadingMutableContainers error:nil];
 
 // NSLog(@"dataInformation %@",dataInfor); //debugResult--->GotAllTheInformatiom
 // NSLog(@"test getstream from url:%d ",[dataArray count]);//debugResult-->getstream from url : 487
 }
 */


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"test getstream from url:%@ ",dataInfor);
    
    //   NSLog(@"test ObjectForKeycity: %@",[dataInfor objectForKey:@"city"]);
    return [self.dataInfor count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [[dataInfor objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@,%@,%@,%@",[[dataInfor objectAtIndex:indexPath.row] objectForKey:@"address"],[[dataInfor objectAtIndex:indexPath.row] objectForKey:@"city"],[[dataInfor objectAtIndex:indexPath.row] objectForKey:@"state"],[[dataInfor objectAtIndex:indexPath.row] objectForKey:@"zip"]];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSString *object = [[dataInfor objectAtIndex:indexPath.row] objectForKey:@"image_url"];
        //     NSString *object2 = [[dataInfor objectAtIndex:indexPath.row] objectForKey:@"name"];
        self.detailViewController.detailItem = object;
        //    self.detailViewController.message = object2;
        

    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
