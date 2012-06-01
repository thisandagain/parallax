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

@property (nonatomic, retain) NSMutableArray *layers;
@property (nonatomic, retain) CMMotionManager *motionManager;

- (void)addLayer:(CGFloat)depth imageNamed:(NSString *)asset frame:(CGRect)frame;
- (void)startListeningToGyro;
- (void)stopListeningToGyro;

@end