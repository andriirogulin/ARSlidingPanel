//
//  ARSPPanelViewControllerSegue.m
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/25/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import "ARSPPanelViewControllerSegue.h"
#import "ARSPContainerController.h"

@implementation ARSPPanelViewControllerSegue

- (void)perform
{
    [self link];
}

- (void)link
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    if ([sourceViewController isKindOfClass:[ARSPContainerController class]] &&
        destinationViewController != nil) {
        ((ARSPContainerController *)sourceViewController).panelViewController = destinationViewController;
    }
}

@end
