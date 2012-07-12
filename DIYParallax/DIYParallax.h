//
//  DIYParallax.h
//  parallax
//
//  Created by Andrew Sliwinski on 6/1/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface DIYParallax : UIView <UIAccelerometerDelegate>
{
    @private CMMotionManager *motionManager;
    @private NSMutableArray *layers;
}

- (void)addLayer:(CGFloat)depth imageNamed:(NSString *)asset frame:(CGRect)frame;
- (void)startListening;
- (void)stopListening;

@end