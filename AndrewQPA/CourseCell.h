//
//  CourseCell.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *unitsLabel;
@property (nonatomic, strong) IBOutlet UIImageView *gradeLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitsPostLabel;

@end
