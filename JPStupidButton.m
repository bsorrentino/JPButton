//
//  JPStupidButton.m
//  AnimationPlay
//
//  Created by James Pozdena on 5/9/11.
//  Copyright 2011 James Pozdena. All rights reserved.
//

#import "JPStupidButton.h"

@interface JPStupidButton()

- (void)setupLayers;
- (void)animateDown;
- (void)animateUp;
- (void)animateStick;
- (CGFloat)ticknessAdjustement;
- (CGFloat)ticknessAdjustementForStick;
- (CGFloat)ticknessAdjustementForPop;

@property (nonatomic, JP_STRONG, getter = getAndResetDefaultImage, readonly) UIImage *jpDefaultImage;
@property (nonatomic, JP_STRONG, getter = getAndResetBackgroundColor, readonly) UIColor *jpBackgroundColor;

@end


@implementation JPStupidButton

@synthesize jpDefaultImage      = jpDefaultImage_;
@synthesize jpBackgroundColor   = jpBackgroundColor_;
@synthesize cornerRadius;
@synthesize buttonMode;
@synthesize isSelected;

@synthesize tickness;

- (BOOL)isSelected
{
    return (state == 1);
    
}

- (CGFloat)ticknessAdjustement {

    CGFloat v ;
    switch (self.tickness) {
        case JPStupidButtonTicknessDouble:
            v = 0.10f;
            break;
        case JPStupidButtonTicknessThin:
            v = 0.15f;
            break;
    }
    CGFloat result = (self.layer.bounds.size.height * v );
    
    NSLog(@"ticknessAdjustement=[%f]", result);
    
    return result;
}
- (CGFloat)ticknessAdjustementForStick {
    CGFloat result = [self ticknessAdjustementForPop];
    
    switch (self.tickness) {
        case JPStupidButtonTicknessDouble:
            result -= (result *0.60f);
            break;
        case JPStupidButtonTicknessThin:
            result -= (result*0.80f);            
            
    }
    
    NSLog(@"ticknessAdjustementForStick=[%f]", result);
    
    return result;
}

- (CGFloat)ticknessAdjustementForPop {
    
    CGFloat v ;
    switch (self.tickness) {
        case JPStupidButtonTicknessDouble:
            v = 0.08f;
            break;
        case JPStupidButtonTicknessThin:
            v = 0.04f;
            break;
            
    }
    CGFloat result = (self.layer.bounds.size.height * v );
    
    NSLog(@"ticknessAdjustementForPop=[%f]", result);
    
    return result;
}

- (UIImage *)getAndResetDefaultImage
{
    if (jpDefaultImage_ == nil ) {
        UIImage *img = [self imageForState:UIControlStateNormal ];
        
        if( img!=nil ) {
            
            jpDefaultImage_ = img;
            
            [self setImage:nil forState:UIControlStateNormal];
        }
    }
    
    return jpDefaultImage_;
    
}

- (UIColor *)getAndResetBackgroundColor 
{
    
    if (jpBackgroundColor_ == nil) {
        
        UIColor *bg = super.backgroundColor;
        
        if( bg != nil ) {
            [self setBackgroundColor:nil];
            jpBackgroundColor_ = bg;
        }
        else {
            jpBackgroundColor_ = [UIColor darkGrayColor]; // default color
        }
    }
    return jpBackgroundColor_;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        
        buttonMode = JPStupidButtonPopMode;
        state = 0;
        cornerRadius = 10.0;
        tickness = JPStupidButtonTicknessThin;
        
    }
    return self;
}

- (void)setupLayers {
    
    if( baseLayer != nil ) {
        NSLog(@"layers already initialized!");
        //[NSException raise:NSInternalInconsistencyException format:@"layers already initialized!"];

    }
    CGFloat base_bound_f = 0.10f;
    CGFloat move_point_f = 0.10f;
    
    CGRect base_bounds = 
        CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height - self.layer.bounds.size.height * base_bound_f);
    
    CGPoint move_point = 
        CGPointMake(0.0f, base_bounds.size.height * move_point_f);
    
    
    self.layer.masksToBounds = NO;
    
    baseLayer = [CALayer layer];
    
    baseLayer.cornerRadius = self.cornerRadius;
    baseLayer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    baseLayer.shadowOpacity = 1.5f;
    baseLayer.shadowColor = [UIColor blackColor].CGColor;
    baseLayer.shadowRadius = 2.5f;
    baseLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    baseLayer.position    = move_point;
    
    CAShapeLayer *shape = [CALayer layer];
    shape.bounds            =  CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height - [self ticknessAdjustement]);
    shape.cornerRadius      = self.cornerRadius;
    shape.anchorPoint       = CGPointMake(0.0f, 0.0f);
    shape.position          = move_point;
    shape.backgroundColor = self.jpBackgroundColor.CGColor;
    
    gradient = [CAGradientLayer layer];
    gradient.anchorPoint      = CGPointMake(0.0f, 0.0f);
    gradient.position         = CGPointMake(0.0f, 0.0f);
    gradient.bounds           = base_bounds;
    gradient.cornerRadius     = self.cornerRadius;
    gradient.borderColor      = [UIColor colorWithRed:0.72f
                                                green:0.72f
                                                 blue:0.72f
                                                alpha:1.0].CGColor;
    gradient.borderWidth      = 0.73;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:0.82f
                                           green:0.82f
                                            blue:0.82f
                                           alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:0.52f
                                           green:0.52f
                                            blue:0.52f
                                           alpha:1.0].CGColor,
                       nil];
    
    
    if( self.jpDefaultImage != nil ) {
        
        CALayer *imageLayer = [CALayer layer];
        
        CGImageRef imgRef = [self.jpDefaultImage CGImage];
        
#if __has_feature(objc_arc)
        imageLayer.contents = (__bridge id)imgRef;
#else
        imageLayer.contents = (id)imgRef;
#endif        
        imageLayer.contentsGravity = @"center";
        imageLayer.contentsScale = 1.2;
        
        [imageLayer setZPosition:-1.0 ];
        [imageLayer setBounds:gradient.bounds];
        [imageLayer setAnchorPoint:CGPointMake(0.0, 0.0)];
        [imageLayer setPosition:CGPointMake(0.0, 0.0)];
        imageLayer.cornerRadius = self.cornerRadius;
        
        [gradient addSublayer:imageLayer];
        
    }
    else {
        
        CATextLayer *textLayer = [CATextLayer layer];
        //    [textLayer bind:@"string" toObject:self withKeyPath:@"titleLabel" options:nil];
        [textLayer setString:self.titleLabel.text]; 
        
        NSLog(@"String %@", self.titleLabel.text);
        
        [textLayer setFont:@"Menlo"];
        [textLayer setFontSize:15.0f];
        [textLayer setForegroundColor:[UIColor darkGrayColor].CGColor];
        [textLayer setShadowColor:[UIColor lightGrayColor].CGColor];
        [textLayer setShadowOpacity:9.0f];
        [textLayer setShadowRadius:.5];
        [textLayer setShadowOffset:CGSizeMake(1.0, 1.0)];
        [textLayer setBounds:gradient.bounds];
        [textLayer setAnchorPoint:CGPointMake(-0.1, -0.1)];
        [textLayer setPosition:CGPointMake(0.0, 0.0)];
        
        [gradient addSublayer:textLayer];
        
    }
    
    [baseLayer addSublayer:shape];
    
    [baseLayer addSublayer:gradient];
    
    [self.layer addSublayer:baseLayer];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch(state)
    {
        case 0:
            state = 1;
            break;
        default:
            state = 0;
            break;
    }
    [self animateDown];  

    [super touchesBegan:touches withEvent:event];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch(buttonMode)
    {
        case JPStupidButtonPopMode:
            [self animateUp];
            break;
        case JPStupidButtonStickMode:
            if (state == 1) {
                [self animateStick];
            } else {
                [self animateUp];
            }
            break;
        default:
            break;
    }
    [super touchesEnded:touches withEvent:event];
    
}

- (void)animateDown
{
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:0.7f
                                           green:0.7f
                                            blue:0.82f
                                           alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:0.4f
                                           green:0.4f
                                            blue:0.52f
                                           alpha:1.0].CGColor,
                       nil];
    gradient.position         = CGPointMake(0.0f, [self ticknessAdjustementForPop]  );
}

- (void)animateUp
{
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:0.82f
                                           green:0.82f
                                            blue:0.82f
                                           alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:0.52f
                                           green:0.52f
                                            blue:0.52f
                                           alpha:1.0].CGColor,
                       nil];
    gradient.position         = CGPointMake(0.0f, 0.0f);
}

- (void)animateStick
{
    gradient.position         = CGPointMake(0.0f, [self ticknessAdjustementForStick]);
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
#if !__has_feature(objc_arc)
    [super dealloc];
#endif    
}

@end
