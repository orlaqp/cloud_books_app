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
	CPWindow _theWindow;
	CPView _contentView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    _theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        _contentView = [_theWindow contentView];

	CPLogRegister(CPLogPopup);
	
	/*
	// Login Button
    _loginButton = [[CPButton alloc] initWithFrame: CGRectMake(225.0, 111, 70.0, 24.0)];
    [_loginButton setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [_loginButton setTitle:CPLocalizedString("LoginButtonText","Login button Text")];
    [_loginButton setTarget:self];
    [_loginButton setAction:@selector(login:)];
    [_contentView addSubview:_loginButton];
    */

	[_contentView setBackgroundColor:[CPColor lightGrayColor]];
	[_theWindow orderFront:self];
	[self startListening:self];
	
	[self askForLoginCredentials:_contentView];
    
    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

- (void)login:(id)sender
{
	[self askForLoginCredentials:_contentView];
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
		var mainMenu = [MainMenuController initMenuForUser:@"user"];
		[mainMenu populateMenuOptions];
		
		CPLog.debug(@"Showing menu bar");
		
		[CPMenu setMenuBarVisible:YES];
		
	}
}

@end
