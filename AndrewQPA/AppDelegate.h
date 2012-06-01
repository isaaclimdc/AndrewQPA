//
//  AppDelegate.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CoursesViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSString *)dataFilePath;
- (void)copyPlistIfNeeded;

@end

@interface UINavigationBar (CustomImage)

-(void)applyDefaultStyle;

@end

//Override For Custom Navigation Bar
@implementation UINavigationBar (CustomImage)

-(void)willMoveToWindow:(UIWindow *)newWindow{
  [super willMoveToWindow:newWindow];
  [self applyDefaultStyle];
}

- (void)applyDefaultStyle {
  // add the drop shadow
  self.layer.shadowColor = [[UIColor blackColor] CGColor];
  self.layer.shadowOffset = CGSizeMake(0, 3);
  self.layer.shadowOpacity = 0.7;
  self.layer.masksToBounds = NO;
  CGRect shadowPath = CGRectMake(self.layer.bounds.origin.x - 10, self.layer.bounds.size.height - 6, self.layer.bounds.size.width + 20, 5);
  self.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowPath].CGPath;
  self.layer.shouldRasterize = YES;
  
  self.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Optima-Bold" size:22.0] forKey:UITextAttributeFont];

}

@end