@import <Foundation/CPObject.j>

@implementation ContactDetails : CPView
{
	CPImage         photo;
	CPImageView		photoView;
}

- (id)initWithFrame:(CGRect)aFrame
{
	
	self = [super initWithFrame:aFrame];
	
	if (self)
	{
		[self setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ];
		
		var photoWidth = 120;
		var photoHeight = 120;
	
		photo = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/Enligne.png" size:CGSizeMake(50.0, 42.0)];
		photoView = [[CPImageView alloc] initWithFrame:CGRectMake(aFrame.size.width - photoWidth - 10,10, photoWidth, photoHeight)];
		[photoView setAutoresizingMask:CPViewMinXMargin | CPViewMinYMargin ];
		[photoView setImageScaling:CPScaleNone];
		[photoView setImage:photo];
		[photoView setBackgroundColor:[CPColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];

		[self addSubview:photoView]
	}
	
	return self;
	
}

@end