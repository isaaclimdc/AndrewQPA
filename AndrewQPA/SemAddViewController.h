//
//  SemAddViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SemAddViewController;

@protocol SemAddViewControllerDelegate <NSObject>
- (void)semAddViewControllerDidCancel:(SemAddViewController *)controller;
- (void)semAddViewController:(SemAddViewController *)controller
                   didAddSem:(NSString *)sem;
@end

@interface SemAddViewController : UIViewController <UITextViewDelegate> {
    NSString *season;
    UITextView *yearField;
    UIButton *fallButton;
    UIButton *springButton;
    UIImageView *bkgImage;
}

@property (nonatomic, weak) id <SemAddViewControllerDelegate> delegate;
@property (nonatomic, retain) NSString *season;
@property (nonatomic, retain) IBOutlet UITextView *yearField;
@property (nonatomic, retain) IBOutlet UIButton *fallButton;
@property (nonatomic, retain) IBOutlet UIButton *springButton;
@property (nonatomic, strong) IBOutlet UIImageView *bkgImage;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)fall:(id)sender;
- (IBAction)spring:(id)sender;

@end
