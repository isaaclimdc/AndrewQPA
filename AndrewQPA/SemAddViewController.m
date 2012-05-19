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
  if (!(year.length == 4)) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a valid year" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
  NSLog(@"%@", season);
}

- (IBAction)spring:(id)sender
{
  season = @"Spring";
}

- (void)textViewDidChange:(UITextView *)textView
{
  if (textView.text.length >= 4)
    textView.text = [textView.text substringToIndex:4];
  //NSLog(@"%@", textView.text);
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
