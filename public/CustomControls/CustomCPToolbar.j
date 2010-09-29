@import <AppKit/CPToolbar.j>

@implementation CustomCPToolbar : CPToolbar
{
	int	_viewHeight;
}

- (CPView)_toolbarView
{
	if(!_viewHeight)
		_viewHeight = 59;
	if(!_toolbarView)
	{
		_toolbarView = [[_CPToolbarView alloc] initWithFrame:CPRectMake(0.0, 0.0, 1200.0, _viewHeight)];
		[_toolbarView setToolbar:self];
		[_toolbarView setAutoresizingMask:CPViewWidthSizable];
		[_toolbarView reloadToolbarItems];
	}
	return _toolbarView;
}

- (void)setHeight:(int)aInt
{
	_viewHeight = aInt;
}


@end