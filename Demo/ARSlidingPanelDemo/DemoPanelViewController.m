//
//  DemoPanelViewController.m
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 3/24/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import "ARSPContainerController.h"
#import "DemoPanelViewController.h"

@interface DemoPanelViewController()

@property (nonatomic, strong) ARSPContainerController *panelControllerContainer;

@property (weak, nonatomic) IBOutlet UISlider *visibleZoneHeightSlider;
@property (weak, nonatomic) IBOutlet UILabel *visibleZoneHeightLabel;

@property (weak, nonatomic) IBOutlet UISlider *swipableZoneHeightSlider;
@property (weak, nonatomic) IBOutlet UILabel *swipableZoneHeightLabel;

@property (weak, nonatomic) IBOutlet UIView *visibleZoneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visibleZoneHeightConstraint;

@property (weak, nonatomic) IBOutlet UIView *swipableZoneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *swipableZoneHeightConstraint;

@end

@implementation DemoPanelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.panelControllerContainer = (ARSPContainerController *)self.parentViewController;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.visibleZoneHeight = self.panelControllerContainer.visibleZoneHeight;
    self.swipableZoneHeight = self.panelControllerContainer.swipableZoneHeight;
}

- (IBAction)visibleZoneHeightSliderAction:(id)sender {
    _visibleZoneHeight = ((UISlider *)sender).value;
    self.panelControllerContainer.visibleZoneHeight = _visibleZoneHeight;
    _visibleZoneHeightLabel.text = [NSString stringWithFormat:@"%.2f", _visibleZoneHeight];
    _visibleZoneHeightConstraint.constant = _visibleZoneHeight;
    [self.view layoutIfNeeded];
}

- (IBAction)swipableZoneHeightSliderAction:(id)sender {
    _swipableZoneHeight = ((UISlider *)sender).value;
    self.panelControllerContainer.swipableZoneHeight = _swipableZoneHeight;
    _swipableZoneHeightLabel.text = [NSString stringWithFormat:@"%.2f", _swipableZoneHeight];
    _swipableZoneHeightConstraint.constant = _swipableZoneHeight;
    [self.view layoutIfNeeded];
}

- (void)setVisibleZoneHeight:(CGFloat)visibleZoneHeight
{
    _visibleZoneHeight = MIN(visibleZoneHeight, _visibleZoneHeightSlider.maximumValue);
    _visibleZoneHeightSlider.value = _visibleZoneHeight;
    _visibleZoneHeightLabel.text = [NSString stringWithFormat:@"%.2f", _visibleZoneHeight];
    _visibleZoneHeightConstraint.constant = _visibleZoneHeight;
    [self.view layoutIfNeeded];
}

- (void)setSwipableZoneHeight:(CGFloat)swipableZoneHeight
{
    _swipableZoneHeight = MIN(swipableZoneHeight, _swipableZoneHeightSlider.maximumValue);
    _swipableZoneHeightSlider.value = _swipableZoneHeight;
    _swipableZoneHeightLabel.text = [NSString stringWithFormat:@"%.2f", _swipableZoneHeight];
    _swipableZoneHeightConstraint.constant = _swipableZoneHeight;
    [self.view layoutIfNeeded];
}


@end
