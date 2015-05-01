//
//  AppDelegate.m
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import "AppDelegate.h"
#import "ARSPContainerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ARSPContainerController *containerController;
    
    // SECTION-1
    // Storyboard integration example (Comment it in case of use SECTION-2)
    
    containerController = (ARSPContainerController *)self.window.rootViewController;
    
    containerController.visibleZoneHeight = 80;
    containerController.swipableZoneHeight = 130;
    containerController.draggingEnabled = YES;
    containerController.shouldOverlapMainViewController = NO;
    containerController.shouldShiftMainViewController = NO;
    
    //***
    
    
    
    
    //*** SECTION-2
    // Integration-via-code simple example (Comment it in case of use SECTION-1)
    
//    containerController = [ARSPContainerController getController];
//
//    UIViewController *mainVC = [[UIViewController alloc]init];
//    [mainVC.view setBackgroundColor:[UIColor blueColor]];
//    
//    UIViewController *panelVC = [[UIViewController alloc]init];
//    [panelVC.view setBackgroundColor:[UIColor yellowColor]];
//
//    containerController.mainViewController = mainVC;
//    containerController.panelViewController = panelVC;
//    
//    containerController.visibleZoneHeight = 80;
//    containerController.swipableZoneHeight = 130;
//    containerController.dropShadow = YES;
//    containerController.draggingEnabled = YES;
//    containerController.shouldOverlapMainViewController = NO;
//    containerController.shouldShiftMainViewController = NO;
    
//    self.window.rootViewController = containerController;
    
    
    //***
    
    
    return YES;
}

@end
