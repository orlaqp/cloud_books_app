@import <Foundation/CPObject.j>

@import "../Models/MenuItem.j"

@implementation MainMenuController : CPObject
{
	CPString _username;
	MenuItem mainMenu		@accessors;
	
}

+ (id)initMenuForUser:(CPString)username
{
	CPLog.debug("Creating Main Menu for user: " + username);
	
	self = [[super alloc] init];
	if (self)
	{
		_username = username;		
	}
	
	return self;
}

- (void)populateMenuOptions
{

	// Setup the menu bar.
	var myApp  = [CPApplication sharedApplication],
		myMenu = [myApp mainMenu];

	var editMenuItem = [myMenu itemWithTitle: @"Cloud Books"]; // Jake FIX - was menuWithTitle.
	[editMenuItem setHidden: NO];

    [CPMenu setMenuBarVisible:YES];

	var listMenu = [[CPMenu alloc] initWithTitle:@"Lists"],
    	listMenuItem = [[CPMenuItem alloc] initWithTitle:@"Lists" action:nil keyEquivalent:nil];

	[listMenu addItem:[[CPMenuItem alloc] initWithTitle:@"Accounts"  action:@selector(zoomIn:)  keyEquivalent:@"+"]];
	[listMenu addItem:[[CPMenuItem alloc] initWithTitle:@"Items" action:@selector(zoomOut:) keyEquivalent:@"-"]];

	[listMenuItem setSubmenu:listMenu];

	// Can't just addItem because of strut aftr Edit menu.
 	var theIndex = [myMenu indexOfItemWithTitle: @"Cloud Books"];
	[myMenu insertItem:listMenuItem atIndex: theIndex+1];
	
	var theNewIndex  = [myMenu indexOfItemWithTitle: @"New" ];
 	var theOpenIndex = [myMenu indexOfItemWithTitle: @"Open"];
 	var theSaveIndex = [myMenu indexOfItemWithTitle: @"Save"];

	// N.B. You have to unwind the menus in reverse order.
	[myMenu removeItemAtIndex:theSaveIndex];
	[myMenu removeItemAtIndex:theOpenIndex];
	[myMenu removeItemAtIndex:theNewIndex];


	/*
	var myMenu = [CPApp mainMenu];

	// Creating Menu Items
	var cloudBookMenu = [[CPMenu alloc] initWithTitle:CPLocalizedString("Cloud Books","Cloud Books")], 
		cloudBookMenuItem = [[CPMenuItem alloc] initWithTitle: CPLocalizedString("Cloud Books","Cloud Books") action:nil keyEquivalent:nil];

	[cloudBookMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString("Backup","Backup") action:nil keyEquivalent:nil]];
	
	[cloudBookMenuItem setSubMenu:cloudBookMenu];
	
	[myMenu insertItem:cloudBookMenuItem atIndex:1];
	

	/*
	// Cloud Books menu
	var cloudBooksMenu = [MenuItem menuWithTitle:CPLocalizedString("Cloud Books","Cloud Books") andAction:nil andKey:nil];
	
	[[cloudBooksMenu childMenuItems] addObject:[MenuItem menuWithTitle:CPLocalizedString("Backup","Backup") andAction:nil andKey:nil]];
	[[cloudBooksMenu childMenuItems] addObject:[MenuItem menuWithTitle:CPLocalizedString("Logoff","Logoff") andAction:nil andKey:nil]];
	
	// Lists
	var listsMenu = [MenuItem menuWithTitle:CPLocalizedString("Lists","Lists") andAction:nil andKey:nil];
	
	[[listsMenu childMenuItems] addObject:[MenuItem menuWithTitle:CPLocalizedString("Accounts","Accounts") andAction:nil andKey:nil]];
	[[listsMenu childMenuItems] addObject:[MenuItem menuWithTitle:CPLocalizedString("Items","Items") andAction:nil andKey:nil]];
	*/
	
	// CPLog.debug("First Child: " + [[[cloudBooksMenu childMenuItems] objectAtIndex:1] title]);
}

@end