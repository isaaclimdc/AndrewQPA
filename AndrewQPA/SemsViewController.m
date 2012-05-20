//
//  SemsViewController.m
//  AndrewQPA
//
//  Created by Isaac Lim on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemsViewController.h"

@interface SemsViewController ()

@end

@implementation SemsViewController

@synthesize sems, mainDict, checkedIndexPath, emptyLabel;

- (IBAction)dismiss:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
}

- (void)semAddViewControllerDidCancel:(SemAddViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)semAddViewController:(SemAddViewController *)controller
                   didAddSem:(NSString *)sem
{
  [sems addObject:sem];
  
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  assert(sems != NULL);
  [mainDict setObject:[[NSMutableArray alloc] initWithCapacity:10] forKey:sem];
  [mainDict writeToFile:[appDelegate dataFilePath] atomically:YES];
  
  NSIndexPath *indexPath = 
  [NSIndexPath indexPathForRow:[sems count]-1 
                     inSection:0];
	[self.tableView insertRowsAtIndexPaths:
   [NSArray arrayWithObject:indexPath] 
                        withRowAnimation:UITableViewRowAnimationAutomatic];
  
  [self updateCheckmarkAtIndexPath:indexPath];
  
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddSem"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		SemAddViewController *semAddViewController = [[navigationController viewControllers] objectAtIndex:0];
		semAddViewController.delegate = self;
	}
}

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
  
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  sems = [[NSMutableArray alloc] initWithCapacity:10];
  mainDict = [[NSMutableDictionary alloc] initWithCapacity:10];
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[appDelegate dataFilePath]];
  if ([dict count] != 0) {
    mainDict = dict;
    sems = [[mainDict allKeys] mutableCopy];
  }
  
  checkedIndexPath = [NSIndexPath indexPathForRow:[sems indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSem"]] inSection:0];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  if ([sems count] == 0) {
    emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 160, 250, 30)];
    emptyLabel.text = @"Please add a new semester.";
    emptyLabel.backgroundColor = [UIColor clearColor];
    emptyLabel.textColor = [UIColor darkGrayColor];
    emptyLabel.font = [UIFont systemFontOfSize:16];
    emptyLabel.shadowColor = [UIColor whiteColor];
    emptyLabel.shadowOffset = CGSizeMake(0, 1);
    [self.tableView addSubview:emptyLabel];
  }
  else {
    [emptyLabel removeFromSuperview];
  }
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [sems count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  if ([sems count] == 0) {
    return nil;
  }
	else {
    return @"Select a semester to view grades.";
  }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
  if ([sems count] == 0) {
    return nil;
  }
	else {
    return @"Grades for courses are recorded in individual semesters. Both the QPA for that semester, and the cumulative QPA are calculated.\n\nQPA is calculated by:\nTotal Quality Points / Total No. of Units";
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"SemsCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  NSUInteger index = [indexPath row];
  cell.textLabel.text = [sems objectAtIndex:index];
  
  if ([indexPath isEqual:checkedIndexPath])
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  else
    cell.accessoryType = UITableViewCellAccessoryNone;
  
  return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSUInteger index = [indexPath row];
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    assert(sems != NULL);
    [mainDict removeObjectForKey:[sems objectAtIndex:index]];
    [mainDict writeToFile:[appDelegate dataFilePath] atomically:YES];
    
    [sems removeObjectAtIndex:index];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    if (index > 0) {
      checkedIndexPath = [NSIndexPath indexPathForRow:index-1 inSection:0];    
      [self updateCheckmarkAtIndexPath:checkedIndexPath];
    }
    else {
      [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"CurrentSem"];
    }
    
    [self dismiss:nil];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self updateCheckmarkAtIndexPath:indexPath];
  [self dismiss:nil];
}

- (void)updateCheckmarkAtIndexPath:(NSIndexPath *)indexPath
{
  NSUInteger index = [indexPath row];
  [[NSUserDefaults standardUserDefaults] setObject:[sems objectAtIndex:index] forKey:@"CurrentSem"];
  
  if (checkedIndexPath != NULL) {
    NSIndexPath *old = checkedIndexPath;
    checkedIndexPath = indexPath;
    if (![old isEqual:checkedIndexPath])
      [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:old, checkedIndexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
  }
  else {
    checkedIndexPath = indexPath;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:checkedIndexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
  }
  
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
