//
//  ARSPContainerController.h
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSPVisibilityState.h"
#import "ARSPDragDelegate.h"
#import "ARSPVisibilityStateDelegate.h"

@interface ARSPContainerController : UIViewController
/**
 Main view controller. Use this property to setup your main view controller via code or access it.
 */
@property (nonatomic, strong) UIViewController *mainViewController;
/**
 Sliding up view controller. Use this property to setup your panel view controller via code or access it.
 */
@property (nonatomic, strong) UIViewController *panelViewController;
/**
 Subscribe for dragging event.
 */
@property (nonatomic, weak) id<ARSPDragDelegate> dragDelegate;
/**
 Subscribe to track visibility state changes
 */
@property (nonatomic, weak) id<ARSPVisibilityStateDelegate> visibilityStateDelegate;
/**
 Current visibility state of Panel view controller
 */
@property (nonatomic, readonly) ARSPVisibilityState visibilityState;
/**
 Define visibility zone's height of Panel view controller in Minimized visibility state
 Default value is 0.0f;
 */
@property (nonatomic) CGFloat visibleZoneHeight;
/**
 Define swipable zone's height of Panel view controller in Maximized visibility state
 If swipable zone height is less than Visibile Zone Height, last one will be used as swipable zone instead
 Default value is 0.f;
 */
@property (nonatomic) CGFloat swipableZoneHeight;
/**
 Maximum panel height when maximized.
 Default is 0.0f, making the panel take up the entire screen.
 */
@property (nonatomic) CGFloat maxPanelHeight;
/**
 Panel view controller drops shadow
 Default value is NO
 */
@property (nonatomic) BOOL dropShadow;
/**
 Shadow radius of Panel view controller
 Default value is 20.0f
 */
@property (nonatomic) CGFloat shadowRadius;
/**
 Shadow opacity of panel view controller
 Default value is 0.5f
 */
@property (nonatomic) CGFloat shadowOpacity;
/**
 Panel view controller will overlay Main view controller in Minimized visibility state
 Default value is NO
 */
@property (nonatomic) BOOL shouldOverlapMainViewController;
/**
 Panel view controller will shift Main view controller on moving
 Default value is NO
 */
@property (nonatomic) BOOL shouldShiftMainViewController;
/**
 Panel view controller opening/closing animation duration
 Default value is 0.3f
 */
@property (nonatomic) CGFloat animationDuration;
/**
 Dragging enabled/disabled for Panel view controller
 Default value is NO
 */
@property (nonatomic) BOOL draggingEnabled;

/**
 Controller cretion. Use it if you want to init ARSlidingPanelController in code
 */
+ (ARSPContainerController *)getController;

/**
 Maximizes Panel view controller to fullscreen mode
 @param animated should be animated
 @param completion completion block
 */
- (void)maximizePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
/**
 Minimizes Panel view controller to dock mode
 @param animated should be animated
 @param completion completion block
 */
- (void)minimizePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
/**
 Removes Panel view controller from screen
 @param animated should be animated
 @param completion completion block
 */
- (void)closePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
/**
 Maximizes Panel view controller to fullscreen mode
 @param animated should be animated
 @param animations custom animations
 @param completion completion block
 */
- (void)maximizePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion;
/**
 Minimizes Panel view controller to dock mode
 @param animated should be animated
 @param animations custom animations
 @param completion completion block
 */
- (void)minimizePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion;
/**
 Removes Panel view controller from screen
 @param animated should be animated
 @param animations custom animations
 @param completion completion block
 */
- (void)closePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion;

@end
