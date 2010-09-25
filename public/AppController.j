/*
 * AppController.j
 * cloud_book
 *
 * Created by You on September 6, 2010.
 * Copyright 2010, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "CPLightbox.j"
@import "Models/User.j"
@import "Views/LoginWindow.j"


@implementation AppController : CPObject
{
	CPWindow 			_theWindow;
	CPView 				_contentView;
	MainMenuController 	_mainMenu;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        _contentView = [_theWindow contentView];

	//CPLogRegister(CPLogPopup);

	[_contentView setBackgroundColor:[CPColor colorWithCalibratedRed:209.0/255.0 green:216.0/255.0 blue:227.0/255.0 alpha:0.7]];
	[_theWindow orderFront:self];
	[self startListening:self];
	
	//[self askForLoginCredentials:_contentView];
	 _mainMenu = [[MainMenuController alloc] initMenuForUser:@"user" andView:_contentView];
	[_mainMenu populateMenuOptions];
}

- (void)askForLoginCredentials:(CPView)aView
{
	var login = [[LoginWindow alloc] initWithContentView:aView];    
	//[CPApp runModalForWindow:[login window]];
	
	[[CPLightbox sharedLightbox] runModalForWindow:[login window]];
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

	    [label setStringValue:@"System's session has been terminated"];
	    [label setFont:[CPFont boldSystemFontOfSize:24.0]];

	    [label sizeToFit];

	    [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
	    [label setCenter:[_contentView center]];

	    [_contentView addSubview:label];
		
	} else {
		// Show main menu
		_mainMenu = [[MainMenuController alloc] initMenuForUser:@"user" andView:_contentView];
		[_mainMenu populateMenuOptions];
		CPLog.debug(@"Showing menu bar");
	}
}

@end
