//
//  AppDelegate.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoursesViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSString *)dataFilePath;
- (void)copyPlistIfNeeded;

@end
