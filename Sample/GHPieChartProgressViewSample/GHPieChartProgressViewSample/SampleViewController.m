//
//  SampleViewController.m
//  GHPieChartProgressViewSample
//
//  Created by Oliver Letterer on 02.09.11.
//  Copyright 2011 Home. All rights reserved.
//

#import "SampleViewController.h"
#import "GHPieChartProgressView.h"

@implementation SampleViewController

- (void)loadView {
    [super loadView];
    
    CGFloat width = 60.0f;
    
    GHPieChartProgressView *progressView = [[GHPieChartProgressView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, width, width)];
    progressView.progress = 0.6f;
    progressView.tintColor = [UIColor greenColor];
    [self.view addSubview:progressView];
    
    progressView = [[GHPieChartProgressView alloc] initWithFrame:CGRectMake(20.0f + width, 10.0f, width, width)];
    progressView.progress = 0.8f;
    progressView.tintColor = [UIColor redColor];
    [self.view addSubview:progressView];
    
    progressView = [[GHPieChartProgressView alloc] initWithFrame:CGRectMake(30.0f + 2.0f * width, 10.0f, width, width)];
    progressView.progress = 0.3f;
    progressView.tintColor = [UIColor yellowColor];
    [self.view addSubview:progressView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
