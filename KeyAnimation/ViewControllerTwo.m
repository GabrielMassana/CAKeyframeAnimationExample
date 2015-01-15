//
//  ViewControllerTwo.m
//  KeyAnimation
//
//  Created by GabrielMassana on 13/01/2015.
//  Copyright (c) 2015 GabrielMassana. All rights reserved.
//

#import "ViewControllerTwo.h"

@implementation ViewControllerTwo


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 20, 320, 80);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonPressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
