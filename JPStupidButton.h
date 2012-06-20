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

typedef enum {
    JPStupidButtonPopMode = 1,
    JPStupidButtonStickMode = 2
} JPStupidButtonMode;

typedef enum {
    JPStupidButtonTicknessThin,
    JPStupidButtonTicknessDouble
} JPStupidButtonTickness;


@interface JPStupidButton : UIButton {
@private    
    int              state;
    CALayer         *baseLayer;
    CAGradientLayer *gradient;
    CGRect           orig_bounds;
}

@property CGFloat cornerRadius; // default 10.0f
@property JPStupidButtonTickness tickness;

@property JPStupidButtonMode buttonMode;

@property (assign, readonly ) BOOL isSelected;
@property (assign ) BOOL displayShadow;

- (void)setupLayers;

@end
