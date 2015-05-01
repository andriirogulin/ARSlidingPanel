//
//  DemoMainViewController.h
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSPContainerController.h"

@interface DemoMainViewController : UIViewController <ARSPDragDelegate, ARSPVisibilityStateDelegate>

@property (nonatomic) BOOL dropShadow;
@property (nonatomic) CGFloat shadowRadius;
@property (nonatomic) CGFloat shadowOpacity;

@property (nonatomic) BOOL shouldOverlapMainViewController;
@property (nonatomic) BOOL shouldShiftMainViewController;

@property (nonatomic) CGFloat animationDuration;

@property (nonatomic) BOOL draggingEnabled;

- (IBAction)showHideAction:(id)sender;

- (IBAction)dropShadowSwitchAction:(id)sender;

- (IBAction)shadowRadiusSliderAction:(id)sender;
- (IBAction)shadowOpacitySliderAction:(id)sender;

- (IBAction)overlapSwitchAction:(id)sender;
- (IBAction)shiftSwitchAction:(id)sender;

- (IBAction)animationDurationSliderAction:(id)sender;

- (IBAction)draggingSwitchAction:(id)sender;

@end

