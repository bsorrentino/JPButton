//
//  AnimationPlayViewController.h
//  AnimationPlay
//
//  Created by James Pozdena on 5/9/11.
//  Copyright 2011 James Pozdena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPStupidButton.h"

@interface AnimationPlayViewController : UIViewController {
    
}

@property (nonatomic,retain) IBOutletCollection(JPStupidButton) NSArray *menuButtons;

- (IBAction)button0:(id)sender;

@end
