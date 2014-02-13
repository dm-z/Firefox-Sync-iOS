//
//  AboutScreen.m
//  Weave
//
//  Created by Dan Walkowski on 6/24/10.
//  Copyright 2010 ClownWare. All rights reserved.
//

#import "AboutScreen.h"
#import "WeaveAppDelegate.h"
#import "Stockboy.h"
#import "TapActionController.h"



@implementation AboutScreen

- (IBAction)done
{
    WeaveAppDelegate *appDelegate = (WeaveAppDelegate *) [[UIApplication sharedApplication] delegate];
    [[appDelegate settings] dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textLabel.text = NSLocalizedString(@"Mozilla, Firefox, and the Mozilla, Firefox, and SyncClient logos are trademarks of the Mozilla Foundation.", nil);
    [self.doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
}

- (void)viewDidUnload
{
    [self setTextLabel:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
}


- (void)dealloc
{
    [_textLabel release];
    [_doneButton release];
    [super dealloc];
}

@end
