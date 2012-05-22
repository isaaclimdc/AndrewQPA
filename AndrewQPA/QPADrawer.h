//
//  QPADrawer.h
//  AndrewQPA
//
//  Created by Isaac Lim on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPADrawer : UIView {
  UIButton *toolbar;
  
  UILabel *label1;
  UILabel *label2;
  UILabel *label3;
  UILabel *label4;
  UILabel *qpaLabel;
  UILabel *unitsLabel;
  UILabel *cumQPALabel;
  UILabel *cumUnitsLabel;
}

@property (nonatomic, retain) IBOutlet UIButton *toolbar;

@property (nonatomic, retain) IBOutlet UILabel *label1;
@property (nonatomic, retain) IBOutlet UILabel *label2;
@property (nonatomic, retain) IBOutlet UILabel *label3;
@property (nonatomic, retain) IBOutlet UILabel *label4;
@property (nonatomic, retain) IBOutlet UILabel *qpaLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitsLabel;
@property (nonatomic, retain) IBOutlet UILabel *cumQPALabel;
@property (nonatomic, retain) IBOutlet UILabel *cumUnitsLabel;

@end
