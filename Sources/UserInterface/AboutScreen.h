//
//  AboutScreen.h
//  Weave
//
//  Created by Dan Walkowski on 6/24/10.
//  Copyright 2010 ClownWare. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutScreen : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *textLabel;
@property (retain, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction) done;

@end
