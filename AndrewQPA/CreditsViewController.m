//
//  CreditsViewController.m
//  AndrewQPA
//
//  Created by Isaac Lim on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreditsViewController.h"

@interface CreditsViewController ()

@end

@implementation CreditsViewController

@synthesize navigationBar, bibTV;

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
  
  navigationBar.topItem.title = [NSString stringWithFormat:@"AndrewQPA v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
  navigationBar.tintColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
  [navigationBar setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
  
  [bibTV flashScrollIndicators];
}

- (IBAction)dismiss:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
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

@end
