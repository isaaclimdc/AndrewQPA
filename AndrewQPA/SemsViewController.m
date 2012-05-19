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

@synthesize sems, mainDict, checkedIndexPath;

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
    
    if (index > 0)
      checkedIndexPath = [NSIndexPath indexPathForRow:index-1 inSection:0];
    
    [self updateCheckmarkAtIndexPath:checkedIndexPath];
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
//  NSUInteger index = [indexPath row];
//  [[NSUserDefaults standardUserDefaults] setObject:[sems objectAtIndex:index] forKey:@"CurrentSem"];
//  
//  if (checkedIndexPath != NULL) {
//    NSIndexPath *old = checkedIndexPath;
//    checkedIndexPath = indexPath;
//    if (![old isEqual:checkedIndexPath])
//      [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:old, checkedIndexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
//  }
//  else {
//    checkedIndexPath = indexPath;
//    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:checkedIndexPath,nil] withRowAnimation:UITableViewRowAnimationAutomatic];
//  }
//  
//  [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
