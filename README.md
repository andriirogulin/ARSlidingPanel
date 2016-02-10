# **ARSlidingPanel** #

ARSlidingPanel is an iOS framework that allows to use 'Google Play Music-like' sliding-up panel in your application.

# Requirements #

iOS 6.0 and later

ARSlidingPanel is compatible with ARC projects. It depends on the following Apple frameworks, which should already be included with most Xcode templates:
- Foundation.framework
- UIKit.framework
- CoreGraphics.framework

You will need the latest developer tools in order to build ARSlidingPanel. Old Xcode versions might work, but compatibility will not be explicitly maintained.

# Adding ARSlidingPanel to your project #

## CocoaPods ##
CocoaPods is the recommended way to add ARSlidingPanel to your project.

1. Add a pod entry for ARSlidingPanel to your Podfile:

 pod 'ARSlidingPanel'

2. Install the pod(s) by running pod install.
3. Include ARSlidingPanel wherever you need it with **#import "ARSPContainerController.h"**.

## Source files ##
Alternatively you can directly add 

* ARSPContainerController.h
* ARSPContainerController.m
* ARSPDragDelegate.h
* ARSPMainViewControllerSegue.h
* ARSPMainViewControllerSegue.m
* ARSPPanelViewControllerSegue.h
* ARSPPanelViewControllerSegue.m
* ARSPVisibilityState.h
* ARSPVisibilityStateDelegate.h

source files to your project

1. Download the latest code version or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop these source files onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include ARSlidingPanel wherever you need it with **#import "ARSPContainerController.h"**.

# Integration #

There are two ways to add ARSlidingPanel to your project.

## Storyboards ##

1) Drag and drop View Controller from your Xcode Object Library on the storyboard

2) Set it's class to **ARSPContainerController**:

![screen shot 2015-04-30 at 7 34 09 pm](https://cloud.githubusercontent.com/assets/12159759/7432029/f89829f6-f02c-11e4-8431-bde3d4627576.png)

3) Add custom segue from ARSPContainerController to the view controller, that will be your Main View Controller.
Set segue's identifier to **ARSPMainViewControllerSegue**
Set segue's class to **ARSPMainViewControllerSegue**

![screen shot 2015-05-01 at 6 09 17 pm](https://cloud.githubusercontent.com/assets/12159759/7432053/3cc3ee94-f02d-11e4-955a-26e6a4d4ce09.png)

4) Add custom segue from ARSPContainerController to the view controller, that will be your Panel View Controller.
Set segue's identifier to **ARSPPanelViewControllerSegue**
Set segue's class to **ARSPPanelViewControllerSegue**

![screen shot 2015-05-01 at 6 09 55 pm](https://cloud.githubusercontent.com/assets/12159759/7432068/56c49fd2-f02d-11e4-9fa3-71d897fa7b4b.png)

5) Set visible zone height, enable dragging, customize behavior, animation speed, shadow etc. and play around!


## Integration-via-code ##

1) Create object of class **ARSPContainerController** and init it with **[ARSPContainerController getController]** function

2) Set it's mainViewController

3) Set it's panelViewController

4) Set visible zone height, enable dragging, customize behavior, animation speed, shadow etc. and play around!

### Example: ###

    ARSPContainerController *containerController = [ARSPContainerController getController];
    UIViewController *mainVC = [[UIViewController alloc]init];
    [mainVC.view setBackgroundColor:[UIColor blueColor]];
    UIViewController *panelVC = [[UIViewController alloc]init];
    [panelVC.view setBackgroundColor:[UIColor yellowColor]];
    containerController.mainViewController = mainVC;
    containerController.panelViewController = panelVC;
    containerController.visibleZoneHeight = 80;
    containerController.draggingEnabled = YES;

...

# Usage #

**ARSPContainerController** - is a main class of ARSlidingPanel framework.
It's a container for two controllers:

**mainViewController** - could be any custom view controller, navigation controller etc.

**panelViewController** - view controller inside panel. Could be any custom view controller, navigation controller etc.

After integration state you can customize behavior of ARSPContainerController.

###Example:###
    // setting height of panel in minimized(docked) mode
    containerController.visibleZoneHeight = 80;
    // setting height of zone where you can swipe down to close(minimize) your panel view controller
    containerController.swipableZoneHeight = 130;
    // enable dragging of panel view controller
    containerController.draggingEnabled = YES;
    
    etc..
    
Please refer to **'ARSPContainerController.h'** file to see all available settings


There are functions to show/hide/close panel view controller:
- (void)maximizePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)minimizePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)closePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;

Also you can add your custom animations to be executed during showing/hiding/closing ...

- (void)maximizePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion;
- (void)minimizePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion;
- (void)closePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion;


You can set your own object as one of **delegates** of ARSPContainerController:

- **visibilityStateDelegate** - subscribes to track **Visibility State changes** of Panel View Controller:

 -(void)panelControllerChangedVisibilityState:(ARSPVisibilityState)state;

Please refer to **'ARSPVisibilityState.h'** to see list of all Visibility States

- **dragDelegate** - subscribes to track **dragging** of Panel View Controller

 -(void)panelControllerWasDragged:(CGFloat)panelControllerVisibility;

Have fun!
