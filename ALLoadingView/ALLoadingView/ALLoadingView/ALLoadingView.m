
//
//  ALLoadingView.m
//  ALLoadingView
//
//  Created by asm.L on 2017/11/16.
//  Copyright © 2017年 asm. All rights reserved.
//

#import "ALLoadingView.h"

static NSString * const kALAnimationKey = @"kALAnimationKey";

@interface ALLoadingView ()<CAAnimationDelegate>

@property(nonatomic, strong) CAShapeLayer *asmLayer;

@end

@implementation ALLoadingView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.loadingColor = [UIColor orangeColor];
    self.successColor = [UIColor greenColor];
    self.errorColor = [UIColor redColor];
    self.exclamationColor = [UIColor purpleColor];
    self.lineWidth = 6;
    self.radius  = 40;
}


#pragma mark - public

- (void)start {
    [self reset];
    [self loading];
}

- (void)endAnimationWithResult:(ALLoadingViewResultType )result {
    [self.layer removeAllAnimations];
    [self.asmLayer removeAllAnimations];
    
    switch (result) {
        case ALLoadingViewResultTypeError:
            self.asmLayer.strokeColor = self.errorColor.CGColor;
            [self error];
            break;
        case ALLoadingViewResultTypeExclamationMark:
            self.asmLayer.strokeColor = self.exclamationColor.CGColor;
            [self exclamationMark];
            break;
            
        default:
            self.asmLayer.strokeColor = self.successColor.CGColor;
            [self success];
            break;
    }
    if (result) {
        
    }else {
        
    }
}

#pragma mark - reset
- (void)reset {
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer removeAllAnimations];
}

- (void) loading {
    CAShapeLayer * shapelayer = [CAShapeLayer layer];
    self.asmLayer = shapelayer;
    self.asmLayer.frame = CGRectMake(0, 0, self.radius * 2 + self.lineWidth, self.radius * 2 + self.lineWidth);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:self.asmLayer.bounds.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //路径
    shapelayer.path = path.CGPath;
    //填充色
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    // 设置线的颜色
    shapelayer.strokeColor = self.loadingColor.CGColor;
    //线的宽度
    shapelayer.lineWidth = self.lineWidth;
    [self.layer addSublayer:shapelayer];
    
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.fromValue = [NSNumber numberWithFloat:0.f];
    anima.toValue = [NSNumber numberWithFloat:1.f];
    anima.duration = 2.0f;
    anima.repeatCount = MAXFLOAT;
    anima.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    anima.autoreverses = YES;
    anima.removedOnCompletion = NO;
    [shapelayer addAnimation:anima forKey:@"strokeEndAniamtion"];
    
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima3.toValue = [NSNumber numberWithFloat:-M_PI*2];
    anima3.duration = 1.0f;
    anima3.repeatCount = MAXFLOAT;
    anima3.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.layer addAnimation:anima3 forKey:@"rotaionAniamtion"];
    
}

#pragma mark - success

// 对号出现
- (void)success {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPoint firstPoint = centerPoint;
    firstPoint.x -= self.radius / 2;
    [path moveToPoint:firstPoint];
    CGPoint secondPoint = centerPoint;
    secondPoint.x -= self.radius / 8;
    secondPoint.y += self.radius / 2;
    [path addLineToPoint:secondPoint];
    CGPoint thirdPoint = centerPoint;
    thirdPoint.x += self.radius / 2;
    thirdPoint.y -= self.radius / 2;
    [path addLineToPoint:thirdPoint];
    
    layer.path = path.CGPath;
    layer.lineWidth = self.lineWidth;
    layer.strokeColor = self.successColor.CGColor;
    layer.fillColor = nil;
    
    // end status
    CGFloat strokeEnd = 1;
    layer.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.0;
    animation.fromValue = @0;
    animation.toValue = @(strokeEnd);
    [layer addAnimation:animation forKey:nil];
}
#pragma mark - error

- (void) error {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
    
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint point1 = centerPoint;
    point1.x -= self.radius / 2;
    point1.y -= self.radius / 2;
    [path moveToPoint:point1];
    
    CGPoint point2 = centerPoint;
    point2.x += self.radius / 2;
    point2.y += self.radius / 2;
    [path addLineToPoint:point2];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    CGPoint point4 = centerPoint;
    point4.x += self.radius / 2;
    point4.y -= self.radius / 2;
    [path2 moveToPoint:point4];
    CGPoint point3 = centerPoint;
    point3.x -= self.radius / 2;
    point3.y += self.radius / 2;
    [path2 addLineToPoint:point3];
    
    [path appendPath:path2];
    
    layer.path = path.CGPath;
    layer.lineWidth = self.lineWidth;
    layer.strokeColor = self.errorColor.CGColor;
    layer.fillColor = nil;
    
    // end status
    CGFloat strokeEnd = 1;
    layer.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.5;
    animation.fromValue = @0;
    animation.toValue = @(strokeEnd);
    [animation setValue:@"needShake" forKey:kALAnimationKey];
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];
}

#pragma mark - exclamationMark
- (void)exclamationMark {
    
    [self markUp];
    [self markDown];
}

// 叹号上半部分出现
- (void)markUp {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    [self.layer addSublayer: layer];
    
    CGFloat partLength = self.radius * 2 / 8;
    CGFloat pathPartCount = 5;
    CGFloat visualPathPartCount = 4;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) - self.radius;
    CGFloat destY = originY + partLength * pathPartCount;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    layer.path = path.CGPath;
    layer.lineWidth = self.lineWidth;
    layer.strokeColor = self.exclamationColor.CGColor;
    layer.fillColor = nil;
    
    // end status
    CGFloat strokeStart = (pathPartCount - visualPathPartCount ) / pathPartCount;
    CGFloat strokeEnd = 1.0;
    layer.strokeStart = strokeStart;
    layer.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @0;
    startAnimation.toValue = @(strokeStart);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @0;
    endAnimation.toValue = @(strokeEnd);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = 0.6;
    anima.delegate = self;
    [anima setValue:@"needShake" forKey:kALAnimationKey];
    
    [layer addAnimation:anima forKey:nil];
}

// 叹号下半部分出现
- (void)markDown {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    [self.layer addSublayer: layer];
    
    CGFloat partLength = self.radius * 2 / 8;
    CGFloat pathPartCount = 2;
    CGFloat visualPathPartCount = 1;
    
    layer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) + self.radius;
    CGFloat destY = originY - partLength * pathPartCount;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    layer.path = path.CGPath;
    layer.lineWidth = self.lineWidth;
    layer.strokeColor = self.exclamationColor.CGColor;
    layer.fillColor = nil;
    
    // end status
    CGFloat strokeStart = (pathPartCount - visualPathPartCount ) / pathPartCount;
    CGFloat strokeEnd = 1.0;
    layer.strokeStart = strokeStart;
    layer.strokeEnd = strokeEnd;
    
    // animation
    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAnimation.fromValue = @0;
    startAnimation.toValue = @(strokeStart);
    
    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAnimation.fromValue = @0;
    endAnimation.toValue = @(strokeEnd);
    
    CAAnimationGroup *anima = [CAAnimationGroup animation];
    anima.animations = @[startAnimation, endAnimation];
    anima.duration = 0.6;
    
    [layer addAnimation:anima forKey:nil];
}

#pragma mark - step7 fail
- (void)shake {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.fromValue = @(-M_PI / 12);
    anima.toValue = @(M_PI / 12);
    anima.duration = 0.1;
    anima.autoreverses = YES;
    anima.repeatCount = 4;
    [self.layer addAnimation:anima forKey:nil];
}

#pragma mark - animation step stop
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:kALAnimationKey] isEqualToString:@"needShake"]) {
        [self shake];
    }
}

@end

