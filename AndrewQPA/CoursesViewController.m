//
//  CoursesViewController.m
//  AndrewQPA
//
//  Created by Isaac Lim on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoursesViewController.h"

@interface CoursesViewController ()

@end

@implementation CoursesViewController

@synthesize courses, qpa;

- (void)courseAddViewControllerDidCancel:
(CourseAddViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)courseAddViewController:(CourseAddViewController *)controller
                   didAddCourse:(Course *)course
{
  [self.courses addObject:course];
  NSIndexPath *indexPath = 
  [NSIndexPath indexPathForRow:[self.courses count] 
                     inSection:0];
	[self.tableView insertRowsAtIndexPaths:
   [NSArray arrayWithObject:indexPath] 
                        withRowAnimation:UITableViewRowAnimationAutomatic];
  
  qpa = [self calculateQPA];
  [self.tableView reloadData];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddCourse"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		CourseAddViewController *courseAddViewController = [[navigationController viewControllers] objectAtIndex:0];
		courseAddViewController.delegate = self;
	}
}

- (int)calculateQualityPoints
{
  int total = 0;
  
  for (int i = 0; i < [self.courses count]; i++) {
    Course *course = [courses objectAtIndex:i];    
    NSString *grade = course.grade;
    int units = course.units;
    
    if ([grade isEqualToString:@"A"])
      total += 4 * units;
    else if ([grade isEqualToString:@"B"])
      total += 3 * units;
    else if ([grade isEqualToString:@"C"])
      total += 2 * units;
    else if ([grade isEqualToString:@"D"])
      total += 1 * units;
  }
  
  return total;
}

- (int)calculateUnits
{
  int total = 0;
  
  for (int i = 0; i < [self.courses count]; i++) {
    Course *course = [courses objectAtIndex:i];    
    total += course.units;
  }
  
  return total;
}

- (float)calculateQPA
{
  return (float)[self calculateQualityPoints] / (float)[self calculateUnits];
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
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
  return [self.courses count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger index = [indexPath row];
  
  if ([self.courses count] != 0 && index == 0)
    return 90;
  else
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSUInteger index = [indexPath row];
  
  if (index == 0) {
    QPACell *cell = (QPACell *)[tableView dequeueReusableCellWithIdentifier:@"QPACell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.qpaLabel.text = [NSString stringWithFormat:@"%.2f", qpa];
    cell.qpaLabel.hidden = ([self.courses count] == 0);
    cell.label.hidden = ([self.courses count] == 0);
    return cell;
  }
  else {
    CourseCell *cell = (CourseCell *)[tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
    Course *course = [courses objectAtIndex:index-1];
    cell.nameLabel.text = course.name;
    cell.unitsLabel.text = [NSString stringWithFormat:@"%d", course.units];
    cell.gradeLabel.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", course.grade]];
    return cell;
  }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

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
  // Navigation logic may go here. Create and push another view controller.
  /*
   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
   // ...
   // Pass the selected object to the new view controller.
   [self.navigationController pushViewController:detailViewController animated:YES];
   */
}

@end
