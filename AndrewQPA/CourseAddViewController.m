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

@synthesize step1, step2, step3;
@synthesize delegate, nameField1, nameField2, unitsField;
@synthesize gradeButtonA, gradeButtonB, gradeButtonC, gradeButtonD, gradeButtonR;
@synthesize gradeStr;
@synthesize saveButton, overviewCourse, overviewUnits;

- (IBAction)cancel:(id)sender
{
	[self.delegate courseAddViewControllerDidCancel:self];
}

- (IBAction)toStep2:(id)sender
{
  [unitsField becomeFirstResponder];
  overviewCourse.text = [nameField1.text stringByAppendingFormat:@"-%@", nameField2.text];
  
  [UIView animateWithDuration:0.5 animations:^ {
    step1.frame = CGRectMake(-320, 0, step1.frame.size.width, step1.frame.size.height);
    step2.frame = CGRectMake(0, 0, step2.frame.size.width, step2.frame.size.height);
  } completion:^(BOOL finished) {
    
  }];
}

- (IBAction)toStep3:(id)sender
{
  [unitsField resignFirstResponder];
  overviewUnits.text = unitsField.text;
  
  [UIView animateWithDuration:0.5 animations:^ {
    step2.frame = CGRectMake(-320, 0, step2.frame.size.width, step2.frame.size.height);
    step3.frame = CGRectMake(0, 0, step3.frame.size.width, step3.frame.size.height);
  } completion:^(BOOL finished) {
    
  }];
}

- (IBAction)save:(id)sender
{
  Course *course = [[Course alloc] init];
  
  course.name = overviewCourse.text;
  course.units = [overviewUnits.text intValue];
  course.grade = gradeStr;
  
	[self.delegate courseAddViewController:self didAddCourse:course];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
  if (nameField1.text.length == 2)
    [nameField2 becomeFirstResponder];
  if (nameField2.text.length == 3)
    [self toStep2:nil];
  if (unitsField.text.length == 2)
    [self toStep3:nil];
}

- (IBAction)gradeA:(id)sender
{
  gradeStr = @"A";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];  
  saveButton.enabled = YES;
}
- (IBAction)gradeB:(id)sender
{
  gradeStr = @"B";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  saveButton.enabled = YES;
}
- (IBAction)gradeC:(id)sender
{
  gradeStr = @"C";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  saveButton.enabled = YES;
}
- (IBAction)gradeD:(id)sender
{
  gradeStr = @"D";
  [gradeButtonA setBackgroundImage:[UIImage imageNamed:@"B.png"] forState:UIControlStateNormal];
  [gradeButtonB setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonC setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonD setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  [gradeButtonR setBackgroundImage:[UIImage imageNamed:@"A.png"] forState:UIControlStateNormal];
  saveButton.enabled = YES;
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
  
  step1.frame = CGRectMake(0, 0, step1.frame.size.width, step1.frame.size.height);
  step2.frame = CGRectMake(320, 0, step2.frame.size.width, step2.frame.size.height);
  step3.frame = CGRectMake(640, 0, step3.frame.size.width, step3.frame.size.height);
  saveButton.enabled = NO;
  [nameField1 becomeFirstResponder];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  [step1 removeFromSuperview];
  [step2 removeFromSuperview];
  [step3 removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
