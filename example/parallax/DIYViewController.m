//
//  DIYViewController.m
//  parallax
//
//  Created by Andrew Sliwinski on 6/1/12.
//  Copyright (c) 2012 DIY, Co. All rights reserved.
//

#import "DIYViewController.h"

@interface DIYViewController ()

@end

@implementation DIYViewController

@synthesize parallax;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    
    parallax = [[DIYParallax alloc] initWithFrame:self.view.frame];

    [parallax addLayer:0.0 imageNamed:@"layer_1@2x.png" frame:CGRectMake(0, 0, 480, 320)];
    [parallax addLayer:0.1 imageNamed:@"layer_2@2x.png" frame:CGRectMake(240, 0, 240, 320)];
    [parallax addLayer:0.2 imageNamed:@"layer_3@2x.png" frame:CGRectMake(240, 160, 240, 160)];
    [parallax addLayer:0.3 imageNamed:@"layer_4@2x.png" frame:CGRectMake(120, 160, 120, 160)];
    [parallax addLayer:0.8 imageNamed:@"layer_5@2x.png" frame:CGRectMake(60, 160, 60, 160)];
    
    [self.view addSubview:parallax];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [parallax startListening];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [parallax stopListening];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - Dealloc

- (void)dealloc
{
    [parallax stopListening];
}

@end