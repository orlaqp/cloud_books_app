@import <AppKit/CPWindowController.j> 

@implementation WindowBase : CPWindowController
{
	CPWindow 			_theWindow;
	CPView 			_theContentView;	
}

- (void)openWindow:(id)sender reuseWindow:(BOOL)isReusable
{
	/*
	if (isReusable)
	{
		appWindows = [CPApp orderedWindows];
		for (var i=0; i < [appWindows count]; i++)
		{
			// alert([appWindows[i] title]);
			if ([appWindows[i] title] == "Account List")
			{
				[appWindows[i] orderFront:self];
				return;
			}
		}
	}
	else
	{
		[self showWindow:sender];
	}
	*/
	[self showWindow:sender];	
}

@end