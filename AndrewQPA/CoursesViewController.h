//
//  CoursesViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CourseCell.h"
#import "QPACell.h"
#import "CourseAddViewController.h"
#import "SemsViewController.h"
#import "AppDelegate.h"
#import "QPADrawer.h"
#import "EditView.h"
#import "SettingsViewController.h"

@interface CoursesViewController : UITableViewController <CourseAddViewControllerDelegate> {
  NSMutableArray *courses;
  NSMutableDictionary *sems;
  NSString *currentSem;
  UIBarButtonItem *addCourseButton;
  float qpa;
  float cumQpa;
  UIImageView *addTip1;
  UIImageView *addTip2;
  
  QPADrawer *qpaDrawer;
  bool drawerOpen;
}

@property (nonatomic, retain) NSMutableArray *courses;
@property (nonatomic, retain) NSMutableDictionary *sems;
@property (nonatomic, retain) NSString *currentSem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addCourseButton;
@property (nonatomic) float qpa;
@property (nonatomic) float cumQpa;
@property (nonatomic, retain) UIImageView *addTip1;
@property (nonatomic, retain) UIImageView *addTip2;
@property (nonatomic, retain) QPADrawer *qpaDrawer;

- (void)updateQPADrawerWithChange:(BOOL)change;

@end
