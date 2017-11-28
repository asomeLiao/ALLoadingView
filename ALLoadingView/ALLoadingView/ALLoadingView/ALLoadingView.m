
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
@property(nonatomic, strong) CAShapeLayer *asmContentLayer;

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
    self.loadingColor = [UIColor colorWithRed:0x46/255.0 green:0x4d/255.0 blue:0x65/255.0 alpha:1.0];
    self.successColor = [UIColor colorWithRed:0x32/255.0 green:0xa9/255.0 blue:0x82/255.0 alpha:1.0];
    self.errorColor = [UIColor colorWithRed:0xff/255.0 green:0x61/255.0 blue:0x51/255.0 alpha:1.0];
    self.exclamationColor = self.errorColor;
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

- (CAShapeLayer *)asmLayer {
    if (_asmLayer == nil) {
        
        _asmLayer = [CAShapeLayer layer];
        _asmLayer.frame = CGRectMake(0, 0, self.radius * 2 + self.lineWidth, self.radius * 2 + self.lineWidth);
        
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:_asmLayer.bounds.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
        
        //路径
        _asmLayer.path = path.CGPath;
        //填充色
        _asmLayer.fillColor = [UIColor clearColor].CGColor;
        // 设置线的颜色
        _asmLayer.strokeColor = self.loadingColor.CGColor;
        //线的宽度
        _asmLayer.lineWidth = self.lineWidth;
        [self.layer addSublayer:_asmLayer];
    }
    return _asmLayer;
}

- (CAShapeLayer *)asmContentLayer {
    if (_asmContentLayer == nil) {
        _asmContentLayer = [CAShapeLayer layer];
        _asmContentLayer.frame = self.bounds;
        [self.layer addSublayer:_asmContentLayer];
    }
    return _asmContentLayer;
}

#pragma mark - reset
- (void)reset {
    
    [self.asmContentLayer removeAllAnimations];
    [self.asmContentLayer removeFromSuperlayer];
    _asmContentLayer = nil;
    [self.layer removeAllAnimations];
}

- (void) loading {
    
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.fromValue = [NSNumber numberWithFloat:0.f];
    anima.toValue = [NSNumber numberWithFloat:1.f];
    anima.duration = 2.0f;
    anima.repeatCount = MAXFLOAT;
    anima.autoreverses = YES;
    anima.removedOnCompletion = NO;
    self.asmLayer.strokeColor = self.loadingColor.CGColor;
    [self.asmLayer addAnimation:anima forKey:@"strokeEndAniamtion"];
    
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima3.toValue = [NSNumber numberWithFloat:-M_PI*2];
    anima3.duration = 1.0f;
    anima3.repeatCount = MAXFLOAT;
    [self.layer addAnimation:anima3 forKey:@"rotaionAniamtion"];
    
}

#pragma mark - success

// 对号出现
- (void)success {

    CAShapeLayer *layer = self.asmContentLayer;

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
    CAShapeLayer *layer = self.asmContentLayer;
    
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
    CAShapeLayer *layer = self.asmContentLayer;
    
    CGFloat partLength = self.radius * 2 / 8;
    CGFloat pathPartCount = 5;
    CGFloat visualPathPartCount = 4;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat originY = CGRectGetMidY(self.bounds) - self.radius+pathPartCount;
    CGFloat destY = originY + partLength * pathPartCount;
    [path moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY)];
    [path addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY)];
    
    //❗️下部分
    CGFloat partLength2 = self.radius * 2 / 8;
    CGFloat pathPartCount2 = 1;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    CGFloat originY2 = CGRectGetMidY(self.bounds) + self.radius-partLength2 * pathPartCount2;
    CGFloat destY2 = originY2 - partLength2 * pathPartCount2;
    [path2 moveToPoint:CGPointMake(CGRectGetMidX(self.bounds), destY2)];
    [path2 addLineToPoint:CGPointMake(CGRectGetMidX(self.bounds), originY2)];
    layer.fillMode = @"forwards";
    [path appendPath:path2];
    
    layer.path = path.CGPath;
    layer.lineWidth = self.lineWidth;
    layer.strokeColor = self.exclamationColor.CGColor;
    layer.fillColor = nil;
    // end status
    CGFloat strokeEnd = 1.0;

    // animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 0.5;
    animation.fromValue = @0;
    animation.toValue = @(strokeEnd);
    [animation setValue:@"needShake" forKey:kALAnimationKey];
    animation.delegate = self;
    [layer addAnimation:animation forKey:nil];


}

#pragma mark - shake
- (void)shake {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima.fromValue = @(-M_PI / 12);
    anima.toValue = @(M_PI / 12);
    anima.duration = 0.1;
    anima.autoreverses = YES;
    anima.repeatCount = 4;
    [self.layer addAnimation:anima forKey:nil];
}

#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:kALAnimationKey] isEqualToString:@"needShake"]) {
        [self shake];
    }
}

@end


