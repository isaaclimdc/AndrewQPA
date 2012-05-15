//
//  CourseAddViewController.m
//  AndrewQPA
//
//  Created by Isaac Lim on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseAddViewController.h"

@interface CourseAddViewController ()

@end

@implementation CourseAddViewController

@synthesize delegate, nameField1, nameField2, unitsField;
@synthesize gradeButtonA, gradeButtonB, gradeButtonC, gradeButtonD, gradeButtonR;
@synthesize gradeStr;

- (IBAction)cancel:(id)sender
{
	[self.delegate courseAddViewControllerDidCancel:self];
}

- (IBAction)save:(id)sender
{
  Course *course = [[Course alloc] init];
  
  course.name = [nameField1.text stringByAppendingFormat:@"-%@", nameField2.text];
  course.units = [unitsField.text intValue];
  course.grade = gradeStr;
  
	[self.delegate courseAddViewController:self didAddCourse:course];
}

- (IBAction)gradeA:(id)sender
{
  gradeStr = @"A";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
}
- (IBAction)gradeB:(id)sender
{
  gradeStr = @"B";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
}
- (IBAction)gradeC:(id)sender
{
  gradeStr = @"C";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
}
- (IBAction)gradeD:(id)sender
{
  gradeStr = @"D";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
}
- (IBAction)gradeR:(id)sender
{
  gradeStr = @"R";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
