//
//  CoursesViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"
#import "CourseCell.h"
#import "QPACell.h"
#import "CourseAddViewController.h"

@interface CoursesViewController : UITableViewController <CourseAddViewControllerDelegate> {
  float qpa;
}

@property (nonatomic, strong) NSMutableArray *courses;
@property (nonatomic) float qpa;

@end
