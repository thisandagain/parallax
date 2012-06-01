//
//  DIYParallax.m
//  parallax
//
//  Created by Andrew Sliwinski on 6/1/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "DIYParallax.h"

//

#define UPDATE_INTERVAL 1.0f/60
#define DRIFT_MULTIPLIER 1.0f

//

@implementation DIYParallax

@synthesize layers;
@synthesize motionManager;

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Init layers object
        layers              = [[NSMutableArray alloc] init];
        
        // Init motion manager
        motionManager       = [[CMMotionManager alloc] init];        
        motionManager.gyroUpdateInterval = UPDATE_INTERVAL;
    }
    
    return self;
}

#pragma mark - Public methods

/**
 * Add layer to view.
 *
 * @param  int  Layer index
 * @param  NSString  Asset name
 * @param  CGPoint  X/Y position of layer
 *
 * @return  void
 */
- (void)addLayer:(CGFloat)depth imageNamed:(NSString *)asset frame:(CGRect)frame
{
    // Track layer
    [layers addObject:[NSNumber numberWithFloat:depth]];
    
    // Render to view
    UIImageView *item       = [[UIImageView alloc] initWithFrame:frame];
    NSString *bundlePath    = [[NSBundle mainBundle] bundlePath];
    UIImage *image          = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", bundlePath, asset]];
    item.image              = image;
    [self insertSubview:item atIndex:[layers count] - 1];
    
    [item release];
    [image release];
}

/**
 * Start listening to gyro updates.
 *
 * @return  void
 */
- (void)startListeningToGyro
{
    if([self.motionManager isGyroAvailable])
    {
        [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler: ^(CMGyroData *gyroData, NSError *error)
         {
             // Gather rotation rate
             CMRotationRate rotate = gyroData.rotationRate;
             
             // Threshold
             CGFloat x = rotate.x;
             CGFloat y = rotate.y;
             x = x < -0.2 || x > 0.2 ? x : 0;
             y = y < -0.2 || y > 0.2 ? y : 0;
             
             // Update
             if (x != 0 || y != 0)
             {
                 [self update:CGPointMake(x, y)];
             }
         }
         ];
    }
}

/**
 * Stops listening to the gyro.
 *
 * @return  void
 */
- (void)stopListeningToGyro
{
    if([self.motionManager isGyroAvailable])
    {
        [motionManager stopGyroUpdates];
    }
    [motionManager release]; motionManager = nil;
}

#pragma mark - Private methods

/**
 * Loops through the layers array and applies subview x/y translations.
 *
 * @param  CGPoint  X/Y translation
 *
 * @returns  void
 */
- (void)update:(CGPoint)point
{
    for (int i = 0; i < [layers count]; i++)
    {
        // View
        UIView *view = [self.subviews objectAtIndex:i];
        
        // Calc
        CGFloat d = [[layers objectAtIndex:i] floatValue];
        CGFloat x = view.bounds.origin.x + (point.x * d * DRIFT_MULTIPLIER);
        CGFloat y = view.bounds.origin.y - (point.y * d * DRIFT_MULTIPLIER);
        
        // Translate
        view.transform = CGAffineTransformTranslate(view.transform, x, y);
    }
}

#pragma mark - Dealloc

- (void)releaseObjects
{
    [motionManager release]; motionManager = nil;
    [layers release]; layers = nil;
}

- (void)dealloc
{    
    [self releaseObjects];
    [super dealloc];
}

@end