//
//  SemsViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SemAddViewController.h"

@interface SemsViewController : UITableViewController <SemAddViewControllerDelegate> {
  NSMutableArray *sems;
  NSMutableDictionary *mainDict;
  NSIndexPath *checkedIndexPath;
}

@property (nonatomic, retain) NSMutableArray *sems;
@property (nonatomic, retain) NSMutableDictionary *mainDict;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;

- (IBAction)dismiss:(id)sender;

@end
