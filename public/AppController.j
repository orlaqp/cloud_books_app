/*
 * AppController.j
 * cloud_book
 *
 * Created by You on September 6, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "Models/User.j"
@import "Views/LoginWindow.j"


@implementation AppController : CPObject
{
	CPWindow _theWindow;
	CPView _contentView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        _contentView = [_theWindow contentView];

	[_contentView setBackgroundColor:[CPColor lightGrayColor]];
	[_theWindow orderFront:self];
	[self startListening:self];
	
	[self askForLoginCredentials:_contentView];
    
    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

- (void)askForLoginCredentials:(CPView)aView
{
	var login = [[LoginWindow alloc] initWithContentView:aView];    
	[CPApp runModalForWindow:[login window]];
}

-(void)startListening:(id)sender
{
    // Add Notification Observer
    [[CPNotificationCenter defaultCenter]
            addObserver:self
               selector:@selector(loginNotification:)
                   name:@"UserLoginResult"
                 object:nil];
}

- (void)loginNotification:(CPNotification)aNotification
{
	var user = [aNotification object];
	if (user == null) {
		var label = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];

	    [label setStringValue:@"System session terminated"];
	    [label setFont:[CPFont boldSystemFontOfSize:24.0]];

	    [label sizeToFit];

	    [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
	    [label setCenter:[_contentView center]];

	    [_contentView addSubview:label];
		
	} else {
		[CPApp abortModal];
	}
}

@end
