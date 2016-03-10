//
//  ARSPContainerController.m
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import "ARSPContainerController.h"
#import "ARSPMainViewControllerSegue.h"
#import "ARSPPanelViewControllerSegue.h"

@interface ARSPContainerController()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint touchPointOffset;
@property (nonatomic) BOOL panelViewControllerShouldDrag;
@property (nonatomic, strong) NSLayoutConstraint *mainViewControllerTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *mainViewControllerHeightConstraint;

@property (nonatomic, strong) NSLayoutConstraint *panelViewControllerTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *panelViewControllerBottomConstraint;

@end

@implementation ARSPContainerController

#pragma mark - Overriding setters

- (void)setMainViewController:(UIViewController *)mainViewController
{
    if (_mainViewController) {
        if (_mainViewController.view.superview) {
            [_mainViewController.view removeFromSuperview];
        }
        [_mainViewController removeFromParentViewController];
    }
    _mainViewController = mainViewController;
    [self addChildViewController:_mainViewController];
    [self.view addSubview:_mainViewController.view];
    [self setupMainViewControllerConstraints];
    
    if (self.panelViewController && self.panelViewController.view) {
        [self.view bringSubviewToFront:self.panelViewController.view];
    }
}

- (void)setupMainViewControllerConstraints
{
    _mainViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.mainViewControllerTopConstraint = [NSLayoutConstraint constraintWithItem:_mainViewController.view
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1
                                                                         constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_mainViewController.view
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.view
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1
                                                             constant:0];
    
    self.mainViewControllerHeightConstraint = [NSLayoutConstraint constraintWithItem:_mainViewController.view
                                                                           attribute:NSLayoutAttributeHeight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeHeight
                                                                          multiplier:1
                                                                            constant:0];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_mainViewController.view
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1
                                                                        constant:0];
    
    [self.view addConstraints:@[self.mainViewControllerTopConstraint, left, self.mainViewControllerHeightConstraint, widthConstraint]];
    [self.view layoutIfNeeded];
}

- (void)setPanelViewController:(UIViewController *)slidingViewController
{
    if (_panelViewController) {
        [_panelViewController removeFromParentViewController];
        if (_panelViewController.view.superview) {
            [_panelViewController.view removeFromSuperview];
        }
    }
    _panelViewController = slidingViewController;
    [self addChildViewController:_panelViewController];
    [self.view addSubview:_panelViewController.view];
    [self setupPanelViewControllerConstraints];
    [self updateSlidingViewControllerFrameWithBottomOffset:_visibleZoneHeight];
    self.visibilityState = ARSPVisibilityStateMinimized;
    [self updateShadow];
    [self setDraggingEnabled:_draggingEnabled];
}

- (void)setupPanelViewControllerConstraints
{
    _panelViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.panelViewControllerTopConstraint = [NSLayoutConstraint constraintWithItem:_panelViewController.view
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1
                                                                          constant:0];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_panelViewController.view
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:1
                                                                         constant:0];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_panelViewController.view
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeWidth
                                                                      multiplier:1
                                                                        constant:0];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_panelViewController.view
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.view
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1
                                                             constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_panelViewController.view
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1
                                                              constant:0];
    
    [self.view addConstraints:@[self.panelViewControllerTopConstraint, left, right, heightConstraint, widthConstraint]];
    [_panelViewController.view layoutIfNeeded];
}

- (void)setVisibilityState:(ARSPVisibilityState)visibilityState
{
    _visibilityState = visibilityState;
    if (self.visibilityStateDelegate) {
        [self.visibilityStateDelegate panelControllerChangedVisibilityState:_visibilityState];
    }
}

- (void)setVisibleZoneHeight:(CGFloat)slidingViewControllerVisiblePartHeight
{
    _visibleZoneHeight = MIN(slidingViewControllerVisiblePartHeight, self.view.frame.size.height);
    [self updateSlidingViewControllerFrameWithBottomOffset:_panelViewController.view.frame.origin.y];
}

- (void)setDropShadow:(BOOL)dropShadow
{
    _dropShadow = dropShadow;
    [self updateShadow];
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    _shadowRadius = shadowRadius;
    [self updateShadow];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    _shadowOpacity = shadowOpacity;
    [self updateShadow];
}

- (void)setShouldOverlapMainViewController:(BOOL)shouldOverlapMainViewController
{
    _shouldOverlapMainViewController = shouldOverlapMainViewController;
    if (self.visibilityState == ARSPVisibilityStateClosed) {
        [self closePanelControllerAnimated:NO completion:nil];
    }
    else {
        [self minimizePanelControllerAnimated:NO completion:nil];
    }
}

- (void)setShouldShiftMainViewController:(BOOL)shouldShiftMainViewController
{
    _shouldShiftMainViewController = shouldShiftMainViewController;
    if (self.visibilityState == ARSPVisibilityStateClosed) {
        [self closePanelControllerAnimated:NO completion:nil];
    }
    else {
        [self minimizePanelControllerAnimated:NO completion:nil];
    }
}

- (void)setDraggingEnabled:(BOOL)draggingEnabled
{
    _draggingEnabled = draggingEnabled;
    if (!_draggingEnabled) {
        if (_panGestureRecognizer && _panelViewController &&_panelViewController.view) {
            [_panelViewController.view removeGestureRecognizer:_panGestureRecognizer];
        }
    }
    else {
        if (!_panGestureRecognizer) {
            _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
        }
        if (_panGestureRecognizer && _panelViewController && _panelViewController.view) {
            [_panelViewController.view addGestureRecognizer:_panGestureRecognizer];
        }
    }
}

#pragma mark - Under the hood

- (void)updateSlidingViewControllerFrameWithBottomOffset:(CGFloat)bottomOffset
{
    if (self.panelViewController && self.panelViewController.view.superview) {
        
        self.panelViewControllerTopConstraint.constant = - bottomOffset;
        
        if (self.shouldShiftMainViewController && self.visibilityState != ARSPVisibilityStateIsClosing) {
            self.mainViewControllerTopConstraint.constant = - bottomOffset + self.visibleZoneHeight;
        }
        else {
            self.mainViewControllerTopConstraint.constant = 0.f;
        }
        
        if (self.shouldOverlapMainViewController || self.visibilityState == ARSPVisibilityStateIsClosing) {
            self.mainViewControllerHeightConstraint.constant = 0;
        }
        else {
            self.mainViewControllerHeightConstraint.constant = - self.visibleZoneHeight;
        }
    }
    [self.view layoutIfNeeded];
}

- (void)updateShadow
{
    if (self.dropShadow) {
        if (self.panelViewController && self.panelViewController.view.superview) {
            self.panelViewController.view.layer.masksToBounds = NO;
            self.panelViewController.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
            self.panelViewController.view.layer.shadowRadius = self.shadowRadius ? : 20.0f;
            self.panelViewController.view.layer.shadowOpacity = self.shadowOpacity ? : 0.5f;
        }
    }
    else {
        self.panelViewController.view.layer.masksToBounds = NO;
        self.panelViewController.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.panelViewController.view.layer.shadowRadius = 0.0f;
        self.panelViewController.view.layer.shadowOpacity = 0.0f;
    }
}

- (void)installPanelViewControllerConstraintToTop
{
    [self.view removeConstraint:self.panelViewControllerTopConstraint];
    self.panelViewControllerTopConstraint = [NSLayoutConstraint constraintWithItem:self.panelViewController.view
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1
                                                                          constant:self.maxPanelHeight ? self.view.frame.size.height - self.maxPanelHeight : 0];
    [self.view addConstraint:self.panelViewControllerTopConstraint];
}

- (void)installPanelViewControllerConstraintToBottom
{
    [self.view removeConstraint:self.panelViewControllerTopConstraint];
    self.panelViewControllerTopConstraint = [NSLayoutConstraint constraintWithItem:self.panelViewController.view
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeBottom
                                                                        multiplier:1
                                                                          constant: - self.visibleZoneHeight];
    [self.view addConstraint:self.panelViewControllerTopConstraint];
}

#pragma mark - Fabric method for creating contoller

+ (ARSPContainerController *)getController
{
    ARSPContainerController *controller = [[ARSPContainerController alloc] init];
    return controller;
}

#pragma mark - Panel controller movement

- (void)maximizePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self maximizePanelControllerAnimated:animated animations:nil completion:completion];
}

- (void)minimizePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self minimizePanelControllerAnimated:animated animations:nil completion:completion];
}

- (void)closePanelControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self closePanelControllerAnimated:animated animations:nil completion:completion];
}

- (void)maximizePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion
{
    self.visibilityState = ARSPVisibilityStateIsMaximizing;
    CGFloat animationDuration = (self.animationDuration ? : 0.3f);
    [self movePanelControllerWithBottomOffset:self.maxPanelHeight ? self.maxPanelHeight : self.panelViewController.view.frame.size.height
                                     animated:animated
                            animationDuration:animationDuration
                                   animations:animations
                                   completion:^{
                                       self.visibilityState = ARSPVisibilityStateMaximized;
                                      [self installPanelViewControllerConstraintToTop];
                                       
                                       if (completion) {
                                           completion();
                                       }
                                   }];
}

- (void)minimizePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion
{
    CGFloat bottomOffset = (self.panelViewControllerTopConstraint.constant == 0 || self.panelViewControllerTopConstraint.constant == self.view.frame.size.height - self.maxPanelHeight)
    ? self.visibleZoneHeight - self.panelViewController.view.frame.size.height
    : self.visibleZoneHeight;
    self.visibilityState = ARSPVisibilityStateIsMinimizing;
    CGFloat animationDuration = (self.animationDuration ? : 0.3f);
    [self movePanelControllerWithBottomOffset:bottomOffset
                                     animated:animated
                            animationDuration:animationDuration
                                   animations:animations
                                   completion:^{
                                       self.visibilityState = ARSPVisibilityStateMinimized;
                                       [self installPanelViewControllerConstraintToBottom];
                                       
                                       if (completion) {
                                           completion();
                                       }
                                   }];
}

- (void)closePanelControllerAnimated:(BOOL)animated animations:(void (^)(void))animations completion:(void (^)(void))completion
{
    self.visibilityState = ARSPVisibilityStateIsClosing;
    CGFloat animationDuration = (self.animationDuration ? : 0.3f);
    [self movePanelControllerWithBottomOffset:- self.panelViewController.view.frame.size.height
                                     animated:animated
                            animationDuration:animationDuration
                                   animations:animations
                                   completion:^{
                                       self.visibilityState = ARSPVisibilityStateClosed;
                                       if (completion) {
                                           completion();
                                       }
                                   }];
}

- (void)movePanelControllerWithBottomOffset:(CGFloat)bottomOffset
                                   animated:(BOOL)animated
                          animationDuration:(CGFloat)animationDuration
                                 animations:(void (^)(void))animations
                                 completion:(void (^)(void))completion
{
    [UIView animateWithDuration:animated ? animationDuration: 0.0f
                          delay:0
         usingSpringWithDamping:self.visibilityState == ARSPVisibilityStateIsMinimizing ? 0.82 : 1
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^
    {
        if (animations) {
            animations();
        }
        [self updateSlidingViewControllerFrameWithBottomOffset:bottomOffset];
    }
                     completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - Handle pan gesture

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan &&
        [gestureRecognizer locationInView:self.panelViewController.view].y <
        MAX(self.swipableZoneHeight, self.visibleZoneHeight)) {
        self.touchPointOffset = [gestureRecognizer locationInView:self.panelViewController.view];
        self.panelViewControllerShouldDrag = YES;
        [self installPanelViewControllerConstraintToBottom];
    }
    
    CGPoint vel = [gestureRecognizer velocityInView:self.view];
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded ||
       gestureRecognizer.state == UIGestureRecognizerStateCancelled)
    {
        if (self.panelViewControllerShouldDrag) {
            self.panelViewControllerShouldDrag = NO;
            self.touchPointOffset = CGPointZero;
            if (vel.y > 0.0f) {
                [self minimizePanelControllerAnimated:YES completion:nil];
            }
            else {
                [self maximizePanelControllerAnimated:YES completion:nil];
            }
        }
    }
    else {
        if (self.panelViewControllerShouldDrag) {
            self.visibilityState = ARSPVisibilityStateIsDragging;
            CGFloat offset = MAX(self.shouldOverlapMainViewController ? 0.0f : self.visibleZoneHeight, self.panelViewController.view.frame.size.height - [gestureRecognizer locationInView:self.view].y + self.touchPointOffset.y);
            if (self.dragDelegate) {
                [self.dragDelegate panelControllerWasDragged:MIN(1.0f, roundf (100*offset/self.view.frame.size.height)/100.0)];
            }
            [self updateSlidingViewControllerFrameWithBottomOffset:MIN(offset, self.panelViewController.view.frame.size.height)];
        }
    }
}

#pragma mark - Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaultValues];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @try {
        [self performSegueWithIdentifier:NSStringFromClass([ARSPMainViewControllerSegue class])
                                  sender:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Unable to link Main View Controller: %@", exception.debugDescription);
    }
    @finally {
        
    }
    
    @try {
        [self performSegueWithIdentifier:NSStringFromClass([ARSPPanelViewControllerSegue class])
                                  sender:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Unable to link Sliding View Controller: %@", exception.debugDescription);
    }
    @finally {
        
    }
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)setupDefaultValues
{
    _visibilityState = ARSPVisibilityStateMinimized;
    
    _visibleZoneHeight = 0.f;
    _swipableZoneHeight = 0.f;
    
    _dropShadow = NO;
    _shadowRadius = 20.f;
    _shadowOpacity = 0.5f;
    
    _shouldOverlapMainViewController = NO;
    _shouldShiftMainViewController = NO;
    
    _animationDuration = 0.3f;
    _draggingEnabled = YES;
}

@end
