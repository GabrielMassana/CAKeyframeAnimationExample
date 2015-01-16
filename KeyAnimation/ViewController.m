//
//  ViewController.m
//  KeyAnimation
//
//  Created by GabrielMassana on 12/01/2015.
//  Copyright (c) 2015 GabrielMassana. All rights reserved.
//
//  Original Animation URL: https://astlyr.files.wordpress.com/2012/09/realization_gif_by_scaredypoopants-d5e9au5.gif
//

#import "ViewController.h"
#import "ViewControllerTwo.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *animationImageView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.animationImageView];
    [self.view addSubview:self.button];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self animateImages];
}

-(void)buttonPressed
{
    ViewControllerTwo *two = [[ViewControllerTwo alloc] init];
    
    [self presentViewController:two animated:YES completion:nil];
}

#pragma mark - Subviews

- (UIImageView *)animationImageView
{
    if (!_animationImageView)
    {
        _animationImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    return _animationImageView;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0,
                                   20,
                                   [[UIScreen mainScreen] bounds].size.width,
                                   80);
        _button.backgroundColor = [UIColor redColor];
        
        [_button addTarget:self
                    action:@selector(buttonPressed)
          forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

#pragma mark - ImageArray

- (NSArray *)getImagesArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index <= 16; index++)
    {
        NSString *imageName = [NSString stringWithFormat:@"frame_%03ld.png", (long)index];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName
                                                         ofType:nil];
        
        // Allocating images with imageWithContentsOfFile makes images to do not cache.
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [array addObject:(id)image.CGImage];
    }
    
    return array;
}

#pragma mark - AnimateImageArray

- (void)animateImages
{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    keyframeAnimation.values = [self getImagesArray];

    keyframeAnimation.repeatCount = 1.0f;
    keyframeAnimation.duration = 2.5;
    
    keyframeAnimation.delegate = self;
    
//    keyframeAnimation.removedOnCompletion = YES;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    
    CALayer *layer = self.animationImageView.layer;
    
    [layer addAnimation:keyframeAnimation
                 forKey:@"girlAnimation"];
    
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [self.animationImageView removeFromSuperview];
        self.animationImageView = nil;
        
        [self.view addSubview:self.animationImageView];
        [self.view bringSubviewToFront:self.button];
        
        self.animationImageView.image = [UIImage imageNamed:@"frame_016"];
        [self.animationImageView.layer removeAnimationForKey:@"girlAnimation"];  // just in case
    }
}

#pragma mark - MemoryManagement

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
