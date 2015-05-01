//
//  ARSPMainViewControllerSegue.m
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import "ARSPMainViewControllerSegue.h"
#import "ARSPContainerController.h"

@implementation ARSPMainViewControllerSegue

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
        ((ARSPContainerController *)sourceViewController).mainViewController = destinationViewController;
    }
}

@end
