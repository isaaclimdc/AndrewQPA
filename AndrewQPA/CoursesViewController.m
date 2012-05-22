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

@synthesize courses, sems, currentSem, addCourseButton, qpa, cumQpa, addTip1, addTip2, qpaDrawer;

- (void)courseAddViewControllerDidCancel:
(CourseAddViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)courseAddViewController:(CourseAddViewController *)controller
                   didAddCourse:(NSMutableDictionary *)course
{
  [courses addObject:course];
  
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
  
  [self updateQPADrawer];
  
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

#pragma mark - QPA Methods

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
  if ([self calculateUnitsfromCourses:c] == 0)
    return -1;
  else
    return (float)[self calculateQualityPointsfromCourses:c] / (float)[self calculateUnitsfromCourses:c];
}

- (int)calculateCumQualityPoints
{
  int cumQualityPoints = 0;
  NSArray *keys = [sems allKeys];
  for (NSString *str in keys) {
    NSMutableArray *c = [sems objectForKey:str];
    cumQualityPoints += [self calculateQualityPointsfromCourses:c];
  }
  
  return cumQualityPoints;
}

- (int)calculateCumUnits
{
  int cumUnits = 0;
  NSArray *keys = [sems allKeys];
  for (NSString *str in keys) {
    NSMutableArray *c = [sems objectForKey:str];
    cumUnits += [self calculateUnitsfromCourses:c];
  }
  
  return cumUnits;
}

- (float)calculateCumQPA
{
  if ([self calculateCumUnits] == 0)
    return -1;
  else
    return (float)[self calculateCumQualityPoints] / (float)[self calculateCumUnits];
}

- (IBAction)showHideQPADrawer:(id)sender
{
  NSUInteger y;
  NSString *img;
  NSString *img_down;
  
  if (drawerOpen) {
    y = 480 - qpaDrawer.toolbar.frame.size.height;
    img = @"toolbar.png";
    img_down = @"toolbar_down.png";
  }
  else {
    y = 480 - qpaDrawer.frame.size.height;
    img = @"toolbar2.png";
    img_down = @"toolbar2_down.png";
  }
  
  [qpaDrawer.toolbar setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
  [qpaDrawer.toolbar setBackgroundImage:[UIImage imageNamed:img_down] forState:UIControlStateHighlighted];
  
  [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationCurveEaseInOut animations:^ {
    qpaDrawer.frame = CGRectMake(0, y, qpaDrawer.frame.size.width, qpaDrawer.frame.size.height);
  } completion:^(BOOL finished) {
    drawerOpen = !drawerOpen;
  }];
}

- (void)updateQPADrawer
{
  qpa = [self calculateQPAfromCourses:courses];
  cumQpa = [self calculateCumQPA];
  
  qpaDrawer.label1.text = (currentSem == nil ? @"QPA:" : [NSString stringWithFormat:@"%@ QPA:", currentSem]);
  qpaDrawer.label2.text = (currentSem == nil ? @"Units:" : [NSString stringWithFormat:@"%@ Units:", currentSem]);
  
  qpaDrawer.qpaLabel.text = (qpa == -1 ? @"0.00" : [NSString stringWithFormat:@"%.2f", qpa]);
  qpaDrawer.unitsLabel.text = [NSString stringWithFormat:@"%d", [self calculateUnitsfromCourses:courses]];
  qpaDrawer.cumQPALabel.text = (cumQpa == -1 ? @"0.00" : [NSString stringWithFormat:@"%.2f", cumQpa]);
  qpaDrawer.cumUnitsLabel.text = [NSString stringWithFormat:@"%d", [self calculateCumUnits]];
}


#pragma mark - View methods

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
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"AndrewQPA v%@", appVersion] message:@"This app was created by Isaac Lim, a Sophomore in the School of Computer Science at Carnegie Mellon University. This app is meant as a non-profit tool for all Carnegie Mellon students.\n\nContact me at http://isaacl.net\n\n--\n\nCredits for photographs used:\n\nCMU Marketing Communications: \"Tartan Plaid\" (http://www.cmu.edu/marcom/brand-guidelines/wordmarks-colors-type.html)\n\nCollege Financial Aid Guide: \"CMU Campus\" (http://www.collegefinancialaidguide.com/pennsylvania-carnegiemellonuniversity-38-243.html)\n\nPittsburgh Post-Gazette: \"Gates-Hillman Center\" (http://old.post-gazette.com/pg/12010/1202524-53.stm)\n\nWikipedia: \"The Fence\" (http://en.wikipedia.org/wiki/File:The_Fence_at_Carnegie_Mellon_University.jpg), \"The Mall\" (http://en.wikipedia.org/wiki/File:The_Mall_Carnegie_Mellon.jpg)\n\nAl-Jamiat: \"Walking to the Sky\" (http://www.al-jamiat.com/college-lifestyle/20-colleges-universities-free-online-courses/)\n\nThese photographs are used in this app for non-commercial purposes." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UINavigationBar
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(115, 20, 90, 60)];
  [button setBackgroundImage:[UIImage imageNamed:@"barlogo.png"] forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage imageNamed:@"barlogo_down.png"] forState:UIControlStateHighlighted];
  [button addTarget:self action:@selector(showCredits) forControlEvents:UIControlEventTouchUpInside];
  [self addShadowToView:button];
  
  [self.navigationController.view addSubview:button];
  
  
  // QPA Drawer
  qpaDrawer = [[QPADrawer alloc] initWithFrame:CGRectMake(0, 436, 320, 194)];
  
  [qpaDrawer.toolbar addTarget:self action:@selector(showHideQPADrawer:) forControlEvents:UIControlEventTouchUpInside];
  
  qpaDrawer.layer.shadowColor = [[UIColor blackColor] CGColor];
  qpaDrawer.layer.shadowOffset = CGSizeMake(0, -qpaDrawer.toolbar.frame.size.height + 3);
  qpaDrawer.layer.shadowOpacity = 0.7;
  qpaDrawer.layer.masksToBounds = NO;
  CGRect shadowPath = CGRectMake(qpaDrawer.layer.bounds.origin.x - 10, qpaDrawer.toolbar.layer.bounds.size.height - 6, qpaDrawer.layer.bounds.size.width + 20, 5);
  qpaDrawer.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowPath].CGPath;
  
  [self.navigationController.view addSubview:qpaDrawer];
  
  
  // UITableView Background
  UIImageView *rootbkg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
  rootbkg.image = [UIImage imageNamed:@"rootbkg.png"];
  self.tableView.backgroundView = rootbkg;
  
  
  //Initializing Course Data
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
  if (currentSem == NULL) {
    addCourseButton.enabled = NO;
    
    addTip1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 65, 160, 53)];
    addTip1.image = [UIImage imageNamed:@"addTip1.png"];
    addTip1.alpha = 0.0;
    [self.navigationController.view addSubview:addTip1];
    [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationCurveEaseIn animations:^ {
      addTip1.alpha = 1.0;
    } completion:^(BOOL finished) {
      
    }];
  }
  else {
    addCourseButton.enabled = YES;
    
    [UIView animateWithDuration:0.5 animations:^ {
      addTip1.alpha = 0.0;
    } completion:^(BOOL finished) {
      [addTip1 removeFromSuperview];
    }];
  }
  
  courses = [[NSMutableArray alloc] initWithArray:[sems objectForKey:currentSem]];
  if (courses.count == 0 && addCourseButton.enabled) {
    addTip2 = [[UIImageView alloc] initWithFrame:CGRectMake(145, 65, 160, 53)];
    addTip2.image = [UIImage imageNamed:@"addTip2.png"];
    addTip2.alpha = 0.0;
    [self.navigationController.view addSubview:addTip2];
    [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationCurveEaseIn animations:^ {
      addTip2.alpha = 1.0;
    } completion:^(BOOL finished) {
      
    }];
  }
  else {
    [UIView animateWithDuration:0.5 animations:^ {
      addTip2.alpha = 0.0;
    } completion:^(BOOL finished) {
      [addTip2 removeFromSuperview];
    }];
  }
  
  [self updateQPADrawer];
  
  [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
  //[super viewWillDisappear:animated];
  if (drawerOpen)
    [self showHideQPADrawer:nil];
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
  return courses.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  NSUInteger index = [indexPath row];
  
  if (courses.count != 0 && index == 0)
    return 70;
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
    cell.sem.text = currentSem;
    cell.sem.hidden = hide;
    
    return cell;
  }
  else {
    CourseCell *cell = (CourseCell *)[tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
    NSMutableDictionary *course = [courses objectAtIndex:index-1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [course objectForKey:@"name"];
    cell.unitsLabel.text = [course objectForKey:@"units"];
    cell.gradeLabel.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [course objectForKey:@"grade"]]];
    if (index % 2 != 0)
      cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row1.png"]];
    else
      cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"row2.png"]];

//    SLOWS APP DOWN!
//    if (index == courses.count)
//      [self addShadowToView:cell.backgroundView];
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
    [sems writeToFile:[appDelegate dataFilePath] atomically:YES];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self updateQPADrawer];
    
    if (courses.count == 0) {
      [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
      
      addTip2 = [[UIImageView alloc] initWithFrame:CGRectMake(145, 65, 160, 53)];
      addTip2.image = [UIImage imageNamed:@"addTip2.png"];
      addTip2.alpha = 0.0;
      [self.navigationController.view addSubview:addTip2];
      [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationCurveEaseIn animations:^ {
        addTip2.alpha = 1.0;
      } completion:^(BOOL finished) {
        
      }];
    }
    else {
      [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:courses.count inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
    }
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
