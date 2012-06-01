//
//  CourseCell.m
//  AndrewQPA
//
//  Created by Isaac Lim on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseCell.h"

@implementation CourseCell

@synthesize nameLabel, unitsLabel, gradeLabel, unitsPostLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  //nameLabel.textColor = [UIColor blackColor];
  //unitsLabel.textColor = [UIColor blackColor];
}

@end
