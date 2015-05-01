//
//  ARSPDragDelegate.h
//  ARSlidingPanel
//
//  Created by Andrii Rogulin on 4/21/15.
//  Copyright (c) 2015 Andrii Rogulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ARSPDragDelegate

- (void)panelControllerWasDragged:(CGFloat)panelControllerVisibility;

@end
