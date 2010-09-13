@import <AppKit/CPWindowController.j> 

@implementation AccountsWindow : CPWindowController
{
	CPWindow 	_theWindow;
	CPView 		_theContentView;
}

- (id)initWithContentView:(CPView)aView
{
	// Set Size and Position
    var windowWidth = 600.0;
    var windowHeight = 350.0;

    _theWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(0, 0, windowWidth, windowHeight) styleMask: CPTitledWindowMask ],
        _theContentView = [_theWindow contentView];

    [_theWindow setFrameOrigin:CGPointMake((CGRectGetWidth([aView bounds]) - windowWidth) / 2.0,
                 (CGRectGetHeight([aView bounds]) - windowHeight) / 2.0)];

	[_theWindow setTitle:@"Account List"];

	 self = [super initWithWindow:_theWindow];

    if (self)
	{
	
	}
	
	return self;
}

@end