//
//  ALTouchView.h
//  ALLoadingView
//
//  Created by asml on 2018/4/24.
//  Copyright © 2018年 asm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALTouchView : UIView
typedef NS_ENUM(NSInteger, ALTouchViewType) {
    ALTouchViewLine=1,
    ALTouchViewRing,
    ALTouchViewCircle,
    ALTouchViewMixed,
};

/**
 *  show ripple view
 *
 *  @param type ripple type
 */
- (void)showWithRippleType:(ALTouchViewType)type;

/**
 *  remove ripple view
 */
- (void)removeFromParentView;

@end
