//
//  CreditsViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditsViewController : UIViewController
{
  UINavigationBar *navigationBar;
  UITextView *bibTV;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITextView *bibTV;

- (IBAction)dismiss:(id)sender;

@end
