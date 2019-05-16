//
//  ALAudioWave.m
//  ALLoadingView
//
//  Created by asml on 2018/4/24.
//  Copyright © 2018年 asm. All rights reserved.
//

#import "ALAudioWave.h"

@implementation ALAudioWave

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) start {
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.backgroundColor = [UIColor orangeColor];
    cancel.frame = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2,self.bounds.size.width/3, self.bounds.size.height/3);
    cancel.layer.cornerRadius = cancel.bounds.size.width/2;
    [self addSubview:cancel];
    [self addRippleLayer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addRippleLayer];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addRippleLayer];
    });
}
- (void)addRippleLayer
{
    CAShapeLayer *rippleLayer = [[CAShapeLayer alloc] init];
    rippleLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    rippleLayer.bounds = self.bounds;
    rippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.width/3, self.bounds.size.height/3)];
    rippleLayer.path = path.CGPath;

    rippleLayer.fillColor = [UIColor orangeColor].CGColor;
    
    [self.layer insertSublayer:rippleLayer below:self.layer];
    
    //addRippleAnimation
    UIBezierPath *beginPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.width/3, self.bounds.size.height/3)];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width/6, self.bounds.size.height/6, self.bounds.size.width, self.bounds.size.height)];
    

    rippleLayer.opacity = 0.0;
    
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    rippleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    rippleAnimation.duration = 1.0;
    rippleAnimation.autoreverses = NO;
    rippleAnimation.removedOnCompletion = NO;
    rippleAnimation.repeatCount = MAXFLOAT;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.7];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 1.0;
    opacityAnimation.autoreverses = NO;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.repeatCount = MAXFLOAT;
//
    [rippleLayer addAnimation:opacityAnimation forKey:@""];
    [rippleLayer addAnimation:rippleAnimation forKey:@""];
    
//    [self performSelector:@selector(removeRippleLayer:) withObject:rippleLayer afterDelay:5.0];
}
@end
