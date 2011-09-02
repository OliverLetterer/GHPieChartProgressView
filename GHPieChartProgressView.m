//
//  GHPieChartProgressView.m
//  iGithub
//
//  Created by Oliver Letterer on 05.07.11.
//  Copyright 2011 Home. All rights reserved.
//

#import "GHPieChartProgressView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GHPieChartProgressView
@synthesize progress=_progress, tintColor=_tintColor, progressLabel=_progressLabel;

#pragma mark - setters and getters

- (void)setProgress:(CGFloat)progress {
    if (progress < 0.0f) {
        progress = 0.0f;
    } else if (progress > 1.0f) {
        progress = 1.0f;
    }
    
    if (progress != _progress) {
        _progress = progress;
        [self setNeedsDisplay];
        
        _progressLabel.text = [NSString stringWithFormat:@"%d %%", (int)(_progress*100)];
        [self setNeedsLayout];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (tintColor != _tintColor) {
        _tintColor = tintColor;
        
        if (_tintGradient) {
            CGGradientRelease(_tintGradient);
        }
        
        CGColorSpaceRef colorSpace = CGColorGetColorSpace(_tintColor.CGColor);
        CGFloat locations[] = {0.0f, 1.0f};
        
        const CGFloat *components = CGColorGetComponents(_tintColor.CGColor);
        size_t numberOfComponents = CGColorGetNumberOfComponents(_tintColor.CGColor);
        CGFloat newComponents[numberOfComponents];
        for (NSUInteger i = 0; i < numberOfComponents; i++) {
            newComponents[i] = components[i] * 0.85f;
        }
        CGColorRef endColor = CGColorCreate(colorSpace, newComponents);
        
        NSArray *colors = [NSArray arrayWithObjects:
                           (__bridge id)self.tintColor.CGColor, 
                           (__bridge id)endColor,
                           nil];
        
        CGColorRelease(endColor);
        _tintGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
        
        [self setNeedsDisplay];
    }
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _progressLabel.backgroundColor = [UIColor clearColor];
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.textAlignment = UITextAlignmentCenter;
        _progressLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
        _progressLabel.shadowOffset = CGSizeMake(0.0f, 2.0f);
        _progressLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [self addSubview:_progressLabel];
        
        self.progress = 0.5f;
        self.progress = 0.0f;
        
        self.layer.needsDisplayOnBoundsChange = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [_progressLabel sizeToFit];
    _progressLabel.center = CGPointMake(CGRectGetWidth(self.bounds)/2.0f, CGRectGetHeight(self.bounds)/2.0f);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect circleRect = CGRectMake(1.0f, 1.0f, CGRectGetWidth(rect)-2.0f, CGRectGetHeight(rect)-2.0f);
    
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    [circle setLineWidth:1.0f];
    
    // now draw the background of our circle
    [[UIColor lightGrayColor] setFill];
    [circle fill];
    
    CGContextSaveGState(ctx);
    CGContextAddPath(ctx, circle.CGPath);
    CGContextClip(ctx);
    
    static CGFloat angleCorrection = -M_PI/2.0f;
    // now display the progress
    CGPoint center = CGPointMake(CGRectGetWidth(rect)/2.0f, CGRectGetHeight(rect)/2.0f);
    CGFloat radius = CGRectGetWidth(rect)/2.0f;
    
    UIBezierPath *progressPath = [UIBezierPath bezierPath];
    [progressPath moveToPoint:CGPointMake(CGRectGetWidth(rect)/2.0f, 0.0f)];
    [progressPath addArcWithCenter:center 
                            radius:radius 
                        startAngle:angleCorrection 
                          endAngle:2.0*M_PI*_progress + angleCorrection
                         clockwise:YES];
    [progressPath addLineToPoint:center];
    [progressPath closePath];
    
    CGContextAddPath(ctx, progressPath.CGPath);
    CGContextClip(ctx);
    
    CGContextDrawRadialGradient(ctx, _tintGradient, center, 0.0f, center, radius, 0);
    
    CGContextRestoreGState(ctx);
    
    // now draw our border
    [[UIColor darkGrayColor] setStroke];
    [circle stroke];
}

#pragma mark - Memory management

- (void)dealloc {
    if (_tintGradient) {
        CGGradientRelease(_tintGradient);
    }
}

@end
