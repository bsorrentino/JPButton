//
//  JPStupidButton.h
//  AnimationPlay
//
//  Created by James Pozdena on 5/9/11.
//  Copyright 2011 James Pozdena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#ifndef JP_STRONG
#if __has_feature(objc_arc)
#define JP_STRONG strong
#else
#define JP_STRONG retain
#endif
#endif

#ifndef JP_WEAK
#if __has_feature(objc_arc_weak)
#define JP_WEAK weak
#elif __has_feature(objc_arc)
#define JP_WEAK unsafe_unretained
#else
#define JP_WEAK assign
#endif
#endif


@interface JPStupidButton : UIButton {
    int              buttonMode;
    int              state;
    CALayer         *baseLayer;
    CAGradientLayer *gradient;
    CGRect           orig_bounds;
}

- (void)setMode:(int) mode;

extern int const JPStupidButtonPopMode;
extern int const JPStupidButtonStickMode;

@end
