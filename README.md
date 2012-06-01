# Parallax
#### Objective-C library for simple implementation of CoreMotion-controlled parallax distortion.

## Installation
- Copy DIYParallax.h and DIYParallax.m into your project
- Add the "CoreMotion" framework to your project

## Getting Started
```objective-c
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
    
    [parallax startListeningToGyro];
}
````

## Public Methods
```
- (void)addLayer:(CGFloat)depth imageNamed:(NSString *)asset frame:(CGRect)frame;
- (void)startListeningToGyro;
- (void)stopListeningToGyro;
```

## Properties
DIYParallax is a subclass of UIView, thus all properties and methods inherent to UIView can be applied. For more information, please check the [UIView class reference](https://developer.apple.com/library/ios/#documentation/uikit/reference/uiview_class/uiview/uiview.html).