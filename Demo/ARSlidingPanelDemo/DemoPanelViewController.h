//
//  DemoPanelViewController.h
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoPanelViewController : UIViewController

@property (nonatomic) CGFloat visibleZoneHeight;
@property (nonatomic) CGFloat swipableZoneHeight;

- (IBAction)visibleZoneHeightSliderAction:(id)sender;
- (IBAction)swipableZoneHeightSliderAction:(id)sender;


@end
