//
//  SemAddViewController.m
//  AndrewQPA
//
//  Created by Isaac Lim on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemAddViewController.h"

@interface SemAddViewController ()

@end

@implementation SemAddViewController

@synthesize delegate, season, yearField, fallButton, springButton;

- (IBAction)cancel:(id)sender
{
	[self.delegate semAddViewControllerDidCancel:self];
}

- (IBAction)save:(id)sender
{
  NSString *year = yearField.text;
  if (year.length != 4 || !([season isEqualToString:@"Spring"] || [season isEqualToString:@"Fall"])) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter valid year" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
  }
  else {
    NSString *semStr = [NSString stringWithFormat:@"%@ %@", season, year];
    [self.delegate semAddViewController:self didAddSem:semStr];
  }
}

- (IBAction)fall:(id)sender
{
  season = @"Fall";
  [springButton setBackgroundImage:[UIImage imageNamed:@"spring.png"] forState:UIControlStateNormal];
  [fallButton setBackgroundImage:[UIImage imageNamed:@"fall_down.png"] forState:UIControlStateNormal];
  self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (IBAction)spring:(id)sender
{
  season = @"Spring";
  [springButton setBackgroundImage:[UIImage imageNamed:@"spring_down.png"] forState:UIControlStateNormal];
  [fallButton setBackgroundImage:[UIImage imageNamed:@"fall.png"] forState:UIControlStateNormal];
  self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
  if (textView.text.length <= 2)
    textView.text = @"20";
  
  if (textView.text.length >= 4) {
    textView.text = [textView.text substringToIndex:4];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    springButton.alpha = 1.0;
    fallButton.alpha = 1.0;
    [UIView commitAnimations];
  }
  else {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    springButton.alpha = 0.0;
    fallButton.alpha = 0.0;
    [UIView commitAnimations];
    
    season = nil;
    [springButton setBackgroundImage:[UIImage imageNamed:@"spring.png"] forState:UIControlStateNormal];
    [fallButton setBackgroundImage:[UIImage imageNamed:@"fall.png"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.enabled = NO;
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  springButton.alpha = 0.0;
  fallButton.alpha = 0.0;
  self.navigationItem.rightBarButtonItem.enabled = NO;
  
  [yearField becomeFirstResponder];
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
