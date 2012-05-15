//
//  CourseAddViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@class CourseAddViewController;

@protocol CourseAddViewControllerDelegate <NSObject>
- (void)courseAddViewControllerDidCancel:(CourseAddViewController *)controller;
- (void)courseAddViewController:(CourseAddViewController *)controller
                   didAddCourse:(Course *)course;
@end

@interface CourseAddViewController : UIViewController {
  UITextView *nameField1;
  UITextView *nameField2;
  UITextView *unitsField;
  UIButton *gradeButtonA;
  UIButton *gradeButtonB;
  UIButton *gradeButtonC;
  UIButton *gradeButtonD;
  UIButton *gradeButtonR;
  NSString *gradeStr;
}

@property (nonatomic, weak) id <CourseAddViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextView *nameField1;
@property (nonatomic, retain) IBOutlet UITextView *nameField2;
@property (nonatomic, retain) IBOutlet UITextView *unitsField;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonA;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonB;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonC;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonD;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonR;
@property (nonatomic, retain) NSString *gradeStr;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction)gradeA:(id)sender;
- (IBAction)gradeB:(id)sender;
- (IBAction)gradeC:(id)sender;
- (IBAction)gradeD:(id)sender;
- (IBAction)gradeR:(id)sender;

@end
