//
//  ARSPVisibilityState.h
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 4/21/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#ifndef SlidingPanel_ARSPVisibilityState_h
#define SlidingPanel_ARSPVisibilityState_h

typedef enum {
    /**
     Panel View Controller is not visible on screen
     */
    ARSPVisibilityStateClosed = 0,
    /**
     Panel View Controller is minimized - only top panel that defines by Visible Height Zone is visible on screen
     */
    ARSPVisibilityStateMinimized,
    /**
     Panel View Controller is maximizing
     */
    ARSPVisibilityStateIsMaximizing,
    /**
     Panel View Controller is minimizing
     */
    ARSPVisibilityStateIsMinimizing,
    /**
     Panel View Controller is closing
     */
    ARSPVisibilityStateIsClosing,
    /**
     Panel View Controller is dragging by user
     */
    ARSPVisibilityStateIsDragging,
    /**
     Panel View Controller is maximized - it's in fullscreen mode
     */
    ARSPVisibilityStateMaximized
} ARSPVisibilityState;

#endif
