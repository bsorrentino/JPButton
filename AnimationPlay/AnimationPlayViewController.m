//
//  AnimationPlayViewController.m
//  AnimationPlay
//
//  Created by James Pozdena on 5/9/11.
//  Copyright 2011 James Pozdena. All rights reserved.
//

#import "AnimationPlayViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation AnimationPlayViewController

@synthesize menuButtons;


- (IBAction)button0:(id)sender 
{
    NSLog(@"button0 tapped! isSelected [%d]", ((JPStupidButton *)sender).isSelected );
    
}

- (void)dealloc
{
#if !__has_feature(objc_arc)
    
    [super dealloc];
#endif
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.view.layer.backgroundColor = [UIColor grayColor].CGColor;
 
    for (JPStupidButton *b in menuButtons) {
        
        b.cornerRadius = 2.5;
        b.tickness = JPStupidButtonTicknessDouble;
        [b setupLayers];
    }
    
    [super viewDidLoad];
    
    {
        JPStupidButton *b = [menuButtons objectAtIndex:0];
        b.buttonMode = JPStupidButtonStickMode;
    }
    {
        JPStupidButton *b = [menuButtons objectAtIndex:1];
        b.buttonMode = JPStupidButtonStickMode;
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
