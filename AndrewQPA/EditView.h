//
//  EditView.h
//  AndrewQPA
//
//  Created by Isaac Lim on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CoursesViewController.h"

@interface EditView : UIView {
  UIView *view;
  UIButton *gradeButtonA;
  UIButton *gradeButtonB;
  UIButton *gradeButtonC;
  UIButton *gradeButtonD;
  UIButton *gradeButtonR;
  NSString *gradeStr;
  NSIndexPath *selectedRow;
}

@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonA;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonB;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonC;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonD;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonR;
@property (nonatomic, retain) NSString *gradeStr;
@property (nonatomic, retain) NSIndexPath *selectedRow;

@end
