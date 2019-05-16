//
//  ALTouchView.m
//  ALLoadingView
//
//  Created by asml on 2018/4/24.
//  Copyright © 2018年 asm. All rights reserved.
//

#import "ALTouchView.h"
@interface ALTouchView ()

@property (nonatomic, strong) UIButton *rippleButton;
@property (nonatomic, strong) NSTimer *rippleTimer;
@property (nonatomic, assign) NSInteger mode;
@property (nonatomic, assign) ALTouchViewType type;

@end
@implementation ALTouchView

- (void)removeFromParentView
{
    if (self.superview) {
        [_rippleButton removeFromSuperview];
        [self closeRippleTimer];
        [self removeAllSubLayers];
        [self removeFromSuperview];
        [self.layer removeAllAnimations];
    }
}

- (void)removeAllSubLayers
{
    for (NSInteger i = 0; [self.layer sublayers].count > 0; i++) {
        [[[self.layer sublayers] firstObject] removeFromSuperlayer];
    }
}

- (void)showWithRippleType:(ALTouchViewType)type
{
    _type = type;
    [self setUpRippleButton];
    
    self.rippleTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(addRippleLayer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_rippleTimer forMode:NSRunLoopCommonModes];
}

- (void)setUpRippleButton
{
    _rippleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _rippleButton.center = self.center;
    _rippleButton.layer.backgroundColor = [UIColor blueColor].CGColor;
    _rippleButton.layer.cornerRadius = 25;
    _rippleButton.layer.masksToBounds = YES;
    _rippleButton.layer.borderColor = [UIColor yellowColor].CGColor;
    _rippleButton.layer.borderWidth = 2;
    [_rippleButton addTarget:self action:@selector(rippleButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_rippleButton];
}

- (void)rippleButtonTouched:(id)sender
{
    [self closeRippleTimer];
    [self addRippleLayer];
}

- (CGRect)makeEndRect
{
    CGRect endRect = CGRectMake(_rippleButton.frame.origin.x, _rippleButton.frame.origin.y, 50, 50);
    endRect = CGRectInset(endRect, -300, -300);
    return endRect;
}

- (void)addRippleLayer
{
    CAShapeLayer *rippleLayer = [[CAShapeLayer alloc] init];
    rippleLayer.position = CGPointMake(200, 200);
    rippleLayer.bounds = CGRectMake(0, 0, 400, 400);
    rippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_rippleButton.frame.origin.x, _rippleButton.frame.origin.y, 50, 50)];
    rippleLayer.path = path.CGPath;
    rippleLayer.strokeColor = [UIColor greenColor].CGColor;
    if (ALTouchViewRing == _type) {
        rippleLayer.lineWidth = 5;
    } else {
        rippleLayer.lineWidth = 1.5;
    }
    
    if (ALTouchViewLine == _type || ALTouchViewRing == _type) {
        rippleLayer.fillColor = [UIColor clearColor].CGColor;
    } else if (ALTouchViewCircle == _type) {
        rippleLayer.fillColor = [UIColor greenColor].CGColor;
    } else if (ALTouchViewMixed == _type) {
        rippleLayer.fillColor = [UIColor grayColor].CGColor;
    }
    
    [self.layer insertSublayer:rippleLayer below:_rippleButton.layer];
    
    //addRippleAnimation
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_rippleButton.frame.origin.x, _rippleButton.frame.origin.y, 50, 50)];
    CGRect endRect = CGRectInset([self makeEndRect], -100, -100);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    rippleLayer.path = endPath.CGPath;
    rippleLayer.opacity = 0.0;
    
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    rippleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    rippleAnimation.duration = 5.0;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.6];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 5.0;
    
    [rippleLayer addAnimation:opacityAnimation forKey:@""];
    [rippleLayer addAnimation:rippleAnimation forKey:@""];
    
    [self performSelector:@selector(removeRippleLayer:) withObject:rippleLayer afterDelay:5.0];
}

- (void)removeRippleLayer:(CAShapeLayer *)rippleLayer
{
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
}

- (void)closeRippleTimer
{
    if (_rippleTimer) {
        if ([_rippleTimer isValid]) {
            [_rippleTimer invalidate];
        }
        _rippleTimer = nil;
    }
}

@end

