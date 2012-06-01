//
//  EditView.m
//  AndrewQPA
//
//  Created by Isaac Lim on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditView.h"

@implementation EditView

@synthesize view, gradeButtonA, gradeButtonB, gradeButtonC, gradeButtonD, gradeButtonR, gradeStr, selectedRow;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    gradeStr = NULL;
    
    [[NSBundle mainBundle] loadNibNamed:@"EditView" owner:self options:nil];
    [self addSubview:self.view];
  }
  return self;
}

- (IBAction)dismiss
{
  [UIView animateWithDuration:0.3 animations:^ {
    self.alpha = 0.0;
  } completion:^(BOOL finished) {
    [self removeFromSuperview];
    
    if (gradeStr != NULL) {
      AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      CoursesViewController *coursesViewController;
      UINavigationController *navigationController = (UINavigationController *)appDelegate.window.rootViewController;
      
      for (UINavigationController *viewC in navigationController.viewControllers) { 
        if ([viewC isKindOfClass:[CoursesViewController class]]) {               
          coursesViewController = (CoursesViewController *) viewC;
        }
      }
      
      [[coursesViewController.courses objectAtIndex:selectedRow.row-1] setObject:gradeStr forKey:@"grade"];
      [coursesViewController.sems setObject:coursesViewController.courses forKey:coursesViewController.currentSem];
      [coursesViewController.sems writeToFile:[appDelegate dataFilePath] atomically:YES];
      
      [coursesViewController.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:selectedRow] withRowAnimation:UITableViewRowAnimationRight];
      
      [coursesViewController updateQPADrawer];
    }
  }];
}

- (IBAction)gradeA:(id)sender
{
  gradeStr = @"A";
  [self dismiss];
}
- (IBAction)gradeB:(id)sender
{
  gradeStr = @"B";
  [self dismiss];
}
- (IBAction)gradeC:(id)sender
{
  gradeStr = @"C";
  [self dismiss];
}
- (IBAction)gradeD:(id)sender
{
  gradeStr = @"D";
  [self dismiss];
}
- (IBAction)gradeR:(id)sender
{
  gradeStr = @"R";
  [self dismiss];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
