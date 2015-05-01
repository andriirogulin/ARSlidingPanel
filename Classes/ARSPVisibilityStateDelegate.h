//
//  ARSPVisibilityStateDelegate.h
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 4/21/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARSPContainerController.h"

@class ARSPContainerController;

@protocol ARSPVisibilityStateDelegate

- (void)panelControllerChangedVisibilityState:(ARSPVisibilityState)state;

@end
