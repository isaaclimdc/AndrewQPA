//
//  QPADrawer.m
//  AndrewQPA
//
//  Created by Isaac Lim on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QPADrawer.h"

@implementation QPADrawer

@synthesize toolbar, settings;
@synthesize label1, label2, label3, label4, qpaLabel, unitsLabel, cumQPALabel, cumUnitsLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self = [[[NSBundle mainBundle] loadNibNamed:@"QPADrawer" owner:self options:nil] objectAtIndex:0];
      self.frame = frame;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
