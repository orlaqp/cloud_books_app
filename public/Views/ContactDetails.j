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
		photo = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/Enligne.png" size:CGSizeMake(50.0, 42.0)];
		photoView = [[CPImageView alloc] initWithFrame:CGRectMake(10,10, 50, 42)];
		[photoView setImageScaling:CPScaleNone];
		[photoView setImage:photo];
		[photoView setBackgroundColor:[CPColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];

		[self addSubview:photoView]
	}
	
	return self;
	
}

@end