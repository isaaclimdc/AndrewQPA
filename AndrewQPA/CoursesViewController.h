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
#import "CourseAddViewController.h"

@interface CoursesViewController : UITableViewController <CourseAddViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *courses;

@end
