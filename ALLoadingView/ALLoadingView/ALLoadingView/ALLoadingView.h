
//
//  ALLoadingView.h
//  ALLoadingView
//
//  Created by asm.L on 2017/11/16.
//  Copyright © 2017年 asm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ALLoadingViewResultTypeSuccess,
    ALLoadingViewResultTypeError,
    ALLoadingViewResultTypeExclamationMark,
} ALLoadingViewResultType;

@interface ALLoadingView : UIView

@property(nonatomic, strong) UIColor *loadingColor;
@property(nonatomic, strong) UIColor *successColor;
@property(nonatomic, strong) UIColor *exclamationColor;
@property(nonatomic, strong) UIColor *errorColor;

@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, assign) CGFloat radius;

- (void) start;
- (void)endAnimationWithResult:(ALLoadingViewResultType )result;
@end
