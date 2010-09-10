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
	var myMenu = [CPApp mainMenu];

	// Creating Menu Items
	var cloudBookMenu = [[CPMenu alloc] initWithTitle:CPLocalizedString("Cloud Books","Cloud Books")], 
		cloudBookMenuItem = [[CPMenuItem alloc] initWithTitle: CPLocalizedString("Cloud Books","Cloud Books") action:nil keyEquivalent:nil];

	//[cloudBookMenu addItem:[[CPMenuItem] alloc] initWithTitle:CPLocalizedString("Backup","Backup") action:nil keyEquivalent:nil];
	
	//[cloudBookMenuItem setSubMenu:cloudBookMenu];
	
	//[myMenu insertItem:cloudBookMenuItem atIndex:1];
	

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
	
	CPLog.debug("First Child: " + [[[cloudBooksMenu childMenuItems] objectAtIndex:1] title]);
}

@end