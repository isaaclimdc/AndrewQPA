//
//  SettingsViewController.m
//  AndrewQPA
//
//  Created by Isaac Lim on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize contactCell;

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
}

- (IBAction)dismiss:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)contact:(id)sender
{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://isaacl.net"]];
}

- (void)viewDidUnload
{
  [self setContactCell:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
