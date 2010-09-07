@import <AppKit/CPWindowController.j> 
@import "../Models/User.j";

@implementation LoginWindow : CPWindowController
{
	CPWindow 	_theWindow;
	CPTextField _lblUsername;
	CPTextField _lblPassword;
	CPTextField _txtUsername,
	CPTextField _txtPassword;
	CPButton	_loginButton;
	CPButton	_quitButton;
	CPTextField _lblMessage;
}

- (id)initWithContentView:(CPView) aView
{

    // Set Size and Position
    var windowWidth = 340.0;
    var windowHeight = 160.0;

    _theWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(0, 0, windowWidth, windowHeight) styleMask: CPHUDBackgroundWindowMask ],
        panelContentView = [_theWindow contentView];

    [_theWindow setFrameOrigin:CGPointMake((CGRectGetWidth([aView bounds]) - windowWidth) / 2.0,
                 (CGRectGetHeight([aView bounds]) - windowHeight) / 2.0)] ;

    self = [super initWithWindow:_theWindow];

    if (self)
    {
            [_theWindow setDelegate:self];
            [_theWindow setTitle:@"User login"];

            // Define label color
            var lblColor = [CPColor colorWithHexString:("00AAFF")];
            
            // Username Label
            _lblUsername = [[CPTextField alloc] initWithFrame:CGRectMake(25.0, 27.5, 175.0, 25.0)] ;
            [_lblUsername setTextColor:lblColor];
            [_lblUsername setStringValue:@"Username: "];
            [panelContentView addSubview:_lblUsername];

            // Password Label
            _lblPassword = [[CPTextField alloc] initWithFrame:CGRectMake(25.0, 57.5, 175.0, 25.0)];
            [_lblPassword setTextColor:lblColor];
            [_lblPassword setStringValue:@"Password: "];
            [panelContentView addSubview:_lblPassword];

            // Username TextBox
            _txtUsername = [[CPTextField alloc] initWithFrame:CGRectMake(125.0, 27.5, 175.0, 28.0)];
            //txtUsername = [CPTextField roundedTextFieldWithStringValue:@"test1" placeholder:@"test2" width:68.0];
            [_txtUsername setBezeled:YES];
            [_txtUsername setBezelStyle:CPTextFieldSquareBezel];
            [_txtUsername setPlaceholderString:@"Enter username"];
            [_txtUsername setEditable:YES];
            [panelContentView addSubview:_txtUsername];

            // Password TextBox
            _txtPassword = [[CPSecureTextField alloc] initWithFrame:CGRectMake(125.0, 57.5, 175.0, 28.0)];
            [_txtPassword setBezeled:YES];
            [_txtPassword setBezelStyle:CPTextFieldSquareBezel];
            [_txtPassword setPlaceholderString:@"Enter password"];
            [_txtPassword setEditable:YES];
            [panelContentView addSubview:_txtPassword];

            // Checkbox Remember login
            //checkRememberLogin = [[CPCheckBox alloc] initWithFrame:CGRectMake(128.0, 87.5, 40.0, 20.0)];
            //[panelContentView addSubview:checkRememberLogin];

            // Label Remember login
            //lblRememberLogin = [[CPTextField alloc] initWithFrame:CGRectMake(150.0, 87.5, 175.0, 20.0)];
            //[lblRememberLogin setTextColor:lblColor];
            //[lblRememberLogin setStringValue:@"Remember me"];
            //[panelContentView addSubview:lblRememberLogin];

			// Login Button
            _loginButton = [[CPButton alloc] initWithFrame: CGRectMake(225.0, 111, 70.0, 24.0)];
            [_loginButton setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
            [_loginButton setTitle:"Login"];
            [_loginButton setTarget:self];
            [_loginButton setAction:@selector(login:)];
            [panelContentView addSubview:_loginButton];

			// Quit Button
            _quitButton = [[CPButton alloc] initWithFrame: CGRectMake(130.0, 111, 70.0, 24.0)];
            [_quitButton setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
            [_quitButton setTitle:"Quit"];
            [_quitButton setTarget:self];
            [_quitButton setAction:@selector(quit:)];
            //[_quitButton setEnabled:NO];
            [panelContentView addSubview:_quitButton];

			// Error Message
            _lblMessage = [[CPTextField alloc] initWithFrame:CGRectMake(25.0, 87.5, 300.0, 20.0)];
            [_lblMessage setTextColor:[CPColor redColor]];
            [panelContentView addSubview:_lblMessage];

			// Set default button
			[_theWindow setDefaultButton:_loginButton];

    }	
    return self;
}

- (void)login:(id)sender 
{
	[_lblMessage setStringValue:@""]
	
	// Validate that both username and password have values before go to the server
	if ([_txtUsername stringValue] == "" || [_txtPassword stringValue] == "")
	{
		[_lblMessage setStringValue:@"Make sure you entered username and password"];
		return;
	}
	
	var user = [User findWithParams:{"username":[_txtUsername stringValue], "password":[_txtPassword stringValue]}];
	if (user == null)
	{
		// Clear Password Field
		[_txtPassword setStringValue:@""]
		
		// Show message to the user
		[_lblMessage setStringValue:@"Username, Password combination not found"]
		
	}
	else 
	{
		[[CPNotificationCenter defaultCenter] postNotificationName:@"UserLoginSuccesfully" object:user] ;
	}
	
}

- (void) quit:(id) sender
{
    [[CPNotificationCenter defaultCenter] postNotificationName:@"UserLoginResult" object:@"NO"] ;
}

@end