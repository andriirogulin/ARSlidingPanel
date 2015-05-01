//
//  DemoMainViewController.m
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoMainViewController.h"

@interface DemoMainViewController ()

@property (nonatomic, strong) ARSPContainerController *panelControllerContainer;

@property (weak, nonatomic) IBOutlet UISwitch *dropShadowSwitch;
@property (weak, nonatomic) IBOutlet UISlider *shadowRadiusSlider;
@property (weak, nonatomic) IBOutlet UILabel *shadowRadiusLabel;

@property (weak, nonatomic) IBOutlet UISlider *shadowOpacitySlider;
@property (weak, nonatomic) IBOutlet UILabel *shadowOpacityLabel;

@property (weak, nonatomic) IBOutlet UISwitch *overlapSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *shiftSwitch;

@property (weak, nonatomic) IBOutlet UISlider *animationDurationSlider;
@property (weak, nonatomic) IBOutlet UILabel *animationDurationLabel;

@property (weak, nonatomic) IBOutlet UISwitch *draggingSwitch;

@end

@implementation DemoMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.panelControllerContainer = (ARSPContainerController *)self.navigationController.parentViewController;
    self.panelControllerContainer.dragDelegate = self;
    self.panelControllerContainer.visibilityStateDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.dropShadow = self.panelControllerContainer.dropShadow;
    self.shadowRadius = self.panelControllerContainer.shadowRadius;
    self.shadowOpacity = self.panelControllerContainer.shadowOpacity;
    self.shouldOverlapMainViewController = self.panelControllerContainer.shouldOverlapMainViewController;
    self.shouldShiftMainViewController = self.panelControllerContainer.shouldShiftMainViewController;
    self.animationDuration = self.panelControllerContainer.animationDuration;
    self.draggingEnabled = self.panelControllerContainer.draggingEnabled;
}

- (void)setDropShadow:(BOOL)dropShadow
{
    _dropShadow = dropShadow;
    [_dropShadowSwitch setOn:_dropShadow];
}

- (void)setShadowRadius:(CGFloat)shadowRadius
{
    _shadowRadius = shadowRadius;
    _shadowRadiusLabel.text = [NSString stringWithFormat:@"%.2f", _shadowRadius];
    _shadowRadiusSlider.value = MIN(_shadowRadius, _shadowRadiusSlider.maximumValue);
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity
{
    _shadowOpacity = shadowOpacity;
    _shadowOpacityLabel.text = [NSString stringWithFormat:@"%.2f", _shadowOpacity];
    _shadowOpacitySlider.value = MIN(_shadowOpacity, _shadowOpacitySlider.maximumValue);
}

- (void)setShouldOverlapMainViewController:(BOOL)shouldOverlapMainViewController
{
    _shouldOverlapMainViewController = shouldOverlapMainViewController;
    [self panelControllerChangedVisibilityState:self.panelControllerContainer.visibilityState];
    [_overlapSwitch setOn:_shouldOverlapMainViewController];
}

- (void)setShouldShiftMainViewController:(BOOL)shouldShiftMainViewController
{
    _shouldShiftMainViewController = shouldShiftMainViewController;
    [_shiftSwitch setOn:_shouldShiftMainViewController];
}

- (void)setAnimationDuration:(CGFloat)animationDuration
{
    _animationDuration = animationDuration;
    _animationDurationLabel.text = [NSString stringWithFormat:@"%.2f", _animationDuration];
    _animationDurationSlider.value = MIN(_animationDuration, _animationDurationSlider.maximumValue);
}

- (void)setDraggingEnabled:(BOOL)draggingEnabled
{
    _draggingEnabled = draggingEnabled;
    [_draggingSwitch setOn:_draggingEnabled];
}

- (IBAction)showHideAction:(id)sender
{
    ARSPVisibilityState currentState = self.panelControllerContainer.visibilityState;
    if (currentState == ARSPVisibilityStateMaximized ||
        currentState == ARSPVisibilityStateMinimized) {
        [self.panelControllerContainer closePanelControllerAnimated:YES completion:nil];
    }
    else if (currentState == ARSPVisibilityStateClosed) {
        [self.panelControllerContainer minimizePanelControllerAnimated:YES completion:nil];
    }
}

- (IBAction)dropShadowSwitchAction:(id)sender {
    _dropShadow = ((UISwitch *)sender).isOn;
    self.panelControllerContainer.dropShadow = _dropShadow;
}

- (IBAction)shadowRadiusSliderAction:(id)sender {
    _shadowRadius = ((UISlider *)sender).value;
    _shadowRadiusLabel.text = [NSString stringWithFormat:@"%.2f", _shadowRadius];
    self.panelControllerContainer.shadowRadius = _shadowRadius;
}

- (IBAction)shadowOpacitySliderAction:(id)sender {
    _shadowOpacity = ((UISlider *)sender).value;
    _shadowOpacityLabel.text = [NSString stringWithFormat:@"%.2f", _shadowOpacity];
    self.panelControllerContainer.shadowOpacity = _shadowOpacity;
}

- (IBAction)overlapSwitchAction:(id)sender {
    _shouldOverlapMainViewController = ((UISwitch *)sender).isOn;
    self.panelControllerContainer.shouldOverlapMainViewController = _shouldOverlapMainViewController;
}

- (IBAction)shiftSwitchAction:(id)sender {
    _shouldShiftMainViewController = ((UISwitch *)sender).isOn;
    self.panelControllerContainer.shouldShiftMainViewController = _shouldShiftMainViewController;
}

- (IBAction)animationDurationSliderAction:(id)sender {
    _animationDuration = ((UISlider *)sender).value;
    _animationDurationLabel.text = [NSString stringWithFormat:@"%.2f", _animationDuration];
    self.panelControllerContainer.animationDuration = _animationDuration;
}

- (IBAction)draggingSwitchAction:(id)sender {
    _draggingEnabled = ((UISwitch *)sender).isOn;
    self.panelControllerContainer.draggingEnabled = _draggingEnabled;
}

#pragma mark - Drag delegate

- (void)panelControllerWasDragged:(CGFloat)panelControllerVisibility {

}

- (void)panelControllerChangedVisibilityState:(ARSPVisibilityState)state {
    if (_shouldOverlapMainViewController) {
        if (state == ARSPVisibilityStateMaximized) {
            [UIView animateWithDuration:0.3 animations:^{
                self.panelControllerContainer.panelViewController.view.alpha = 1;
            }];
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                self.panelControllerContainer.panelViewController.view.alpha = 0.9;
            }];
        }
    }
    else {
        self.panelControllerContainer.panelViewController.view.alpha = 1;
    }
}
@end
