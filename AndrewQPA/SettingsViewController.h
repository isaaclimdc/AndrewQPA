//
//  SettingsViewController.h
//  AndrewQPA
//
//  Created by Isaac Lim on 6/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *contactCell;

- (IBAction)dismiss:(id)sender;
- (IBAction)contact:(id)sender;

@end
