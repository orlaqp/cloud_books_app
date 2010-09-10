
@implementation MenuItem : CPObject
{
	CPString 	title 			@accessors;
	CPString 	action			@accessors;
	CPString 	keyEquivalent	@accessors;	
	
	CPArray		childMenuItems	@accessors;
	
}

+ (id)menuWithTitle:(CPString)aTitle andAction:(CPString)anAction andKey:(CPString)aKey
{
	return [[self alloc] initWithTitle:aTitle andAction:anAction andKey:aKey];
}

- (id)initWithTitle:(CPString)aTitle andAction:(CPString)anAction andKey:(CPString)aKey
{
	self = [super init];
	if (self)
	{		
		title = aTitle;
		action = anAction;
		keyEquivalent = aKey;
	}
	// Initialize child menu elements
	childMenuItems = [[CPArray alloc] init];
	
	return self;
}

@end