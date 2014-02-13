/***** BEGIN LICENSE BLOCK *****
 Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
 The contents of this file are subject to the Mozilla Public License Version 
 1.1 (the "License"); you may not use this file except in compliance with 
 the License. You may obtain a copy of the License at 
 http://www.mozilla.org/MPL/
 
 Software distributed under the License is distributed on an "AS IS" basis,
 WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 for the specific language governing rights and limitations under the
 License.
 
 The Original Code is weave-iphone.
 
 The Initial Developer of the Original Code is Mozilla Labs.
 Portions created by the Initial Developer are Copyright (C) 2009
 the Initial Developer. All Rights Reserved.
 
 Contributor(s):
 Dan Walkowski <dwalkowski@mozilla.com>
 Stefan Arentz <stefan@arentz.ca>
 
 Alternatively, the contents of this file may be used under the terms of either
 the GNU General Public License Version 2 or later (the "GPL"), or the GNU
 Lesser General Public License Version 2.1 or later (the "LGPL"), in which case
 the provisions of the GPL or the LGPL are applicable instead of those above.
 If you wish to allow use of your version of this file only under the terms of
 either the GPL or the LGPL, and not to allow others to use your version of
 this file under the terms of the MPL, indicate your decision by deleting the
 provisions above and replace them with the notice and other provisions
 required by the GPL or the LGPL. If you do not delete the provisions above, a
 recipient may use your version of this file under the terms of any one of the
 MPL, the GPL or the LGPL.
 
 ***** END LICENSE BLOCK *****/

#import "WelcomePage.h"
#import "WeaveAppDelegate.h"
#import "JPAKEReporter.h"
#import "UIColor+appColors.h"

JPAKEReporter *gSharedReporter = nil;



@implementation WelcomePage

@synthesize setupButton = _setupButton;

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"ru"] || [language isEqualToString:@"id"])
    {
        _setupButton.titleLabel.font = [UIFont fontWithName:_setupButton.titleLabel.font.fontName
                                                       size:_setupButton.titleLabel.font.pointSize - 2.0];
    }

    //if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
    {
        self.setupButton.backgroundColor = [UIColor buttonsColor];
        self.setupButton.layer.cornerRadius = 4.0f;
        [self.setupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self setupLocaleStrings];
}

#pragma mark - private

- (void)setupLocaleStrings
{
    self.titleLabel.text = NSLocalizedString(@"SyncClient requires a Firefox Sync account. Use Firefox on your computer to create an account.", );
    [self.setupButton setTitle:NSLocalizedString(@"I Have A Sync Account", )
                      forState:UIControlStateNormal];
    [self.setupButton setTitle:NSLocalizedString(@"I Have A Sync Account", )
                      forState:UIControlStateHighlighted];
}

- (void)manualSetupViewControllerDidLogin:(ManualSetupViewController *)vc
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showedFirstRunPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [vc dismissModalViewControllerAnimated:NO];
    [self dismissModalViewControllerAnimated:NO];
}

- (void)manualSetupViewControllerDidCancel:(ManualSetupViewController *)vc
{
    [vc dismissModalViewControllerAnimated:YES];
}

#pragma mark -

- (void)easySetupViewControllerDidLogin:(EasySetupViewController *)vc
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showedFirstRunPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [vc dismissModalViewControllerAnimated:NO];
    [self dismissModalViewControllerAnimated:NO];
}

- (void)easySetupViewControllerDidCancel:(EasySetupViewController *)vc
{
    [vc dismissModalViewControllerAnimated:YES];
}

- (void)easySetupViewController:(EasySetupViewController *)vc
               didFailWithError:(NSError *)error
{
    [vc dismissModalViewControllerAnimated:YES];

    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Received J-PAKE Error"
                                                     message:[error localizedDescription]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

- (void)easySetupViewControllerDidRequestManualSetup:(EasySetupViewController *)vc
{
    [vc dismissModalViewControllerAnimated:NO];

    ManualSetupViewController *manualSetupViewController = [[ManualSetupViewController new] autorelease];
    if (manualSetupViewController != nil)
    {
        manualSetupViewController.delegate = self;
        [self presentModalViewController:manualSetupViewController animated:YES];
    }
}

#pragma mark - actions

- (IBAction)presentEasySetupViewController;
{
    WeaveAppDelegate *delegate = (WeaveAppDelegate *) [[UIApplication sharedApplication] delegate];

    if ([delegate canConnectToInternet] == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cannot Setup Sync", @"Cannot Setup Sync")
                                                        message:NSLocalizedString(@"No internet connection available", "no internet connection")
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"ok")
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {
        EasySetupViewController *easySetupViewController = [[EasySetupViewController new] autorelease];
        if (easySetupViewController != nil)
        {
            NSURL *server = [NSURL URLWithString:@"https://setup.services.mozilla.com"];

#if defined(FXHOME_USE_STAGING_JPAKE)
			server = [NSURL URLWithString: @"https://stage-setup.services.mozilla.com"];
#endif

            if (gSharedReporter == nil)
            {
                gSharedReporter = [[JPAKEReporter alloc] initWithServer:server];
            }

            easySetupViewController.reporter = gSharedReporter;
            easySetupViewController.server = server;
            easySetupViewController.delegate = self;
            [self presentModalViewController:easySetupViewController animated:YES];
        }
    }
}

- (void)dealloc
{
    [_titleLabel release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [super viewDidUnload];
}
@end
