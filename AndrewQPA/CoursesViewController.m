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

@synthesize courses, sems, currentSem, addCourseButton, qpa, cumQpa;

- (void)courseAddViewControllerDidCancel:
(CourseAddViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)courseAddViewController:(CourseAddViewController *)controller
                   didAddCourse:(NSMutableDictionary *)course
{
  [courses addObject:course];
  //NSLog(@"Courses length: %d", [courses count]);
  
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  assert(sems != NULL);
  
  [sems setObject:courses forKey:currentSem];
  [sems writeToFile:[appDelegate dataFilePath] atomically:YES];
  
  NSIndexPath *indexPath = 
  [NSIndexPath indexPathForRow:[courses count] 
                     inSection:0];
	[self.tableView insertRowsAtIndexPaths:
   [NSArray arrayWithObject:indexPath] 
                        withRowAnimation:UITableViewRowAnimationAutomatic];
  
  qpa = [self calculateQPAfromCourses:courses];
  cumQpa = [self calculateCumQPA];
  
  [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
  
  CourseCell *cell = (CourseCell *)[self.tableView cellForRowAtIndexPath:indexPath];
  cell.unitsLabel.alpha = 1.0;
  cell.unitsPostLabel.alpha = 1.0;
  cell.gradeLabel.frame = CGRectMake(265, 0, cell.gradeLabel.frame.size.width, cell.gradeLabel.frame.size.height);
  
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

- (int)calculateQualityPointsfromCourses:(NSMutableArray *)c
{
  int total = 0;
  
  for (int i = 0; i < [c count]; i++) {
    NSMutableDictionary *course = [c objectAtIndex:i];    
    NSString *grade = [course objectForKey:@"grade"];
    int units = [[course objectForKey:@"units"] intValue];
    
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

- (int)calculateUnitsfromCourses:(NSMutableArray *)c
{
  int total = 0;
  
  for (int i = 0; i < [c count]; i++) {
    NSMutableDictionary *course = [c objectAtIndex:i];    
    total += [[course objectForKey:@"units"] intValue];
  }
  
  return total;
}

- (float)calculateQPAfromCourses:(NSMutableArray *)c
{
  return (float)[self calculateQualityPointsfromCourses:c] / (float)[self calculateUnitsfromCourses:c];
}

- (float)calculateCumQPA
{
  int cumQualityPoints = 0;
  int cumUnits = 0;
  
  NSArray *keys = [sems allKeys];
  for (NSString *str in keys) {
    NSMutableArray *c = [sems objectForKey:str];
    cumQualityPoints += [self calculateQualityPointsfromCourses:c];
    cumUnits += [self calculateUnitsfromCourses:c];
  }
  
  return (float)cumQualityPoints / (float)cumUnits;
}

- (void)addShadowToView:(UIView *)V
{
  V.layer.shadowColor = [UIColor blackColor].CGColor;
  V.layer.shadowOffset = CGSizeMake(0, 3);
  V.layer.shadowOpacity = 0.6;
  V.layer.shadowRadius = 1.0;
  V.clipsToBounds = NO;
}

- (void)showCredits
{
  NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"AndrewQPA v%@", appVersion] message:@"This app was created by Isaac Lim, a Sophomore in the School of Computer Science at Carnegie Mellon University. This app is meant as a non-profit tool for all Carnegie Mellon students.\n\nContact me at http://isaacl.net\n\n--\n\nCredits for photographs used:\n\nCMU Marketing Communications: \"Tartan Plaid\" (http://www.cmu.edu/marcom/brand-guidelines/wordmarks-colors-type.html)\n\nPittsburgh Post-Gazette: \"Gates-Hillman Center\" (http://old.post-gazette.com/pg/12010/1202524-53.stm)\n\nWikipedia: \"The Fence\" (http://en.wikipedia.org/wiki/File:The_Fence_at_Carnegie_Mellon_University.jpg), \"The Mall\" (http://en.wikipedia.org/wiki/File:The_Mall_Carnegie_Mellon.jpg)\n\nAl-Jamiat: \"Walking to the Sky\" (http://www.al-jamiat.com/college-lifestyle/20-colleges-universities-free-online-courses/)\n\nThese photographs are used in this app for non-commercial purposes." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(115, 20, 90, 60)];
  [button setBackgroundImage:[UIImage imageNamed:@"barlogo.png"] forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"barlogo_down.png"] forState:UIControlStateHighlighted];
  [button addTarget:self action:@selector(showCredits) forControlEvents:UIControlEventTouchUpInside];
  [self addShadowToView:button];
  
  [self.navigationController.view addSubview:button];
  
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  sems = [[NSMutableDictionary alloc] initWithCapacity:10];
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:[appDelegate dataFilePath]];
  if ([dict count] != 0)
    sems = dict;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  currentSem = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentSem"];
  //NSLog(@"%@", currentSem);
  if (currentSem == NULL) {
    addCourseButton.enabled = NO;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome to AndrewQPA!" message:@"Please tap on the top left button to add a semester." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
  }
  else {
    addCourseButton.enabled = YES;
  }
  
  courses = [[NSMutableArray alloc] initWithArray:[sems objectForKey:currentSem]];
  qpa = [self calculateQPAfromCourses:courses];
  cumQpa = [self calculateCumQPA];
  
  [self.tableView reloadData];
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
    return 100;
  else
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSUInteger index = [indexPath row];
  
  if (index == 0) {
    QPACell *cell = (QPACell *)[tableView dequeueReusableCellWithIdentifier:@"QPACell"];
    BOOL hide = ([courses count] == 0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label.text = [NSString stringWithFormat:@"Your %@ QPA is:", currentSem];
    cell.label.hidden = hide;
    cell.qpaLabel.text = [NSString stringWithFormat:@"%.2f", qpa];
    cell.qpaLabel.hidden = hide;
    cell.label2.hidden = hide;
    cell.cumQpaLabel.text = [NSString stringWithFormat:@"%.2f", cumQpa];
    cell.cumQpaLabel.hidden = hide;
    
    return cell;
  }
  else {
    CourseCell *cell = (CourseCell *)[tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
    NSMutableDictionary *course = [courses objectAtIndex:index-1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [course objectForKey:@"name"];
    cell.unitsLabel.text = [course objectForKey:@"units"];
    cell.gradeLabel.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [course objectForKey:@"grade"]]];
    return cell;
  }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([indexPath row] == 0)
    return NO;
  else
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSUInteger index = [indexPath row];
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [courses removeObjectAtIndex:index-1];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    assert(sems != NULL);
    assert(courses != NULL);
    [sems setObject:courses forKey:currentSem];
    //NSLog(@"Sems: %d", [sems count]);
    [sems writeToFile:[appDelegate dataFilePath] atomically:YES];
    //NSLog(@"S12: %d", [[[[NSMutableDictionary alloc] initWithContentsOfFile:[appDelegate dataFilePath]] objectForKey:@"S12"] count]);
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    qpa = [self calculateQPAfromCourses:courses];
    cumQpa = [self calculateCumQPA];
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
  }  
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
  CourseCell *cell = (CourseCell *)[tableView cellForRowAtIndexPath:indexPath];
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.3];
  [UIView setAnimationBeginsFromCurrentState:YES];
	cell.unitsLabel.alpha = 0.0;
  cell.unitsPostLabel.alpha = 0.0;
  cell.gradeLabel.frame = CGRectMake(200, 0, cell.gradeLabel.frame.size.width, cell.gradeLabel.frame.size.height);
  [UIView commitAnimations];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
  CourseCell *cell = (CourseCell *)[tableView cellForRowAtIndexPath:indexPath];
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.3];
  [UIView setAnimationBeginsFromCurrentState:YES];
	cell.unitsLabel.alpha = 1.0;
  cell.unitsPostLabel.alpha = 1.0;
  cell.gradeLabel.frame = CGRectMake(265, 0, cell.gradeLabel.frame.size.width, cell.gradeLabel.frame.size.height);
  [UIView commitAnimations];
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
  // Navigation logic may go here. Create and push another view controller.
  /*
   <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
   // ...
   // Pass the selected object to the new view controller.
   [self.navigationController pushViewController:detailViewController animated:YES];
   */
}

@end
