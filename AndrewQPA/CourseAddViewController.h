//
//  CourseAddViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CourseAddViewController;

@protocol CourseAddViewControllerDelegate <NSObject>
- (void)courseAddViewControllerDidCancel:(CourseAddViewController *)controller;
- (void)courseAddViewController:(CourseAddViewController *)controller
                   didAddCourse:(NSMutableDictionary *)course;
@end

@interface CourseAddViewController : UIViewController <UITextViewDelegate> {
    UIView *step1;
    UIView *step2;
    UIView *step3;
    UIView *summaryView;

    UIImageView *step1Bkg;
    UIImageView *step2Bkg;
    UIImageView *step3Bkg;
    UIImageView *summaryBkg;

    UITextView *nameField1;
    UITextView *nameField2;
    UITextView *unitsField;
    UIButton *gradeButtonA;
    UIButton *gradeButtonB;
    UIButton *gradeButtonC;
    UIButton *gradeButtonD;
    UIButton *gradeButtonR;
    NSString *gradeStr;

    UIBarButtonItem *saveButton;
    UILabel *overviewCourse;
    UILabel *overviewUnits;
}

@property (nonatomic, weak) id <CourseAddViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIView *step1;
@property (nonatomic, retain) IBOutlet UIView *step2;
@property (nonatomic, retain) IBOutlet UIView *step3;
@property (nonatomic, retain) IBOutlet UIView *summaryView;
@property (nonatomic, retain) IBOutlet UIImageView *step1Bkg;
@property (nonatomic, retain) IBOutlet UIImageView *step2Bkg;
@property (nonatomic, retain) IBOutlet UIImageView *step3Bkg;
@property (nonatomic, retain) IBOutlet UIImageView *summaryBkg;
@property (nonatomic, retain) IBOutlet UITextView *nameField1;
@property (nonatomic, retain) IBOutlet UITextView *nameField2;
@property (nonatomic, retain) IBOutlet UITextView *unitsField;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonA;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonB;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonC;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonD;
@property (nonatomic, retain) IBOutlet UIButton *gradeButtonR;
@property (nonatomic, retain) NSString *gradeStr;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) IBOutlet UILabel *overviewCourse;
@property (nonatomic, retain) IBOutlet UILabel *overviewUnits;

- (IBAction)cancel:(id)sender;
- (IBAction)toStep2:(id)sender;
- (IBAction)toStep3:(id)sender;
- (IBAction)save:(id)sender;

- (IBAction)gradeA:(id)sender;
- (IBAction)gradeB:(id)sender;
- (IBAction)gradeC:(id)sender;
- (IBAction)gradeD:(id)sender;
- (IBAction)gradeR:(id)sender;

@end
