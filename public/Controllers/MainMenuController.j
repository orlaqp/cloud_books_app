@import <Foundation/CPObject.j>

@import "../Models/MenuItem.j"
@import "../Views/AccountsWindow.j"

@implementation MainMenuController : CPObject
{
	CPView 		_mainView;
	CPString 	_username;
	MenuItem 	mainMenu		@accessors;
	
}

- (id)initMenuForUser:(CPString)username andView:(CPView)aView
{
	CPLog.debug("Creating Main Menu for user: " + username);
	
	self = [super init];
	if (self)
	{
		_mainView = aView;
		_username = username;		
	}
	return self;
}

- (void)populateMenuOptions
{

	// Setup the menu bar.
	var myApp  = [CPApplication sharedApplication],
		myMenu = [myApp mainMenu];
	
	// Cloud Books
	var cloudBooksMenu 		= [[CPMenu alloc] initWithTitle:CPLocalizedString(@"Cloud Books",@"Cloud Books")],
		cloudBooksMenuItem 	= [[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Cloud Books",@"Cloud Books") action:nil keyEquivalent:nil];		
	[cloudBooksMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Backup",@"Backup") action:@selector(backup:) keyEquivalent:@"B"]];
	[cloudBooksMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Logoff",@"Logoff") action:@selector(logoff:) keyEquivalent:@"L"]];
	[cloudBooksMenuItem setSubmenu:cloudBooksMenu];
	
	// List Menu
	var listMenu = [[CPMenu alloc] initWithTitle:CPLocalizedString(@"Lists",@"Lists")],
    	listMenuItem = [[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Lists",@"Lists") action:nil keyEquivalent:nil];
	[listMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Accounts",@"Accounts")  action:@selector(accountList:)  keyEquivalent:@"A"]];
	[listMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Items",@"Items") action:@selector(itemList:) keyEquivalent:@"T"]];
	[listMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Customers",@"Customers") action:@selector(customerList:) keyEquivalent:@"C"]];
	[listMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Vendors",@"Vendors") action:@selector(vendorList:) keyEquivalent:@"V"]];
	[listMenuItem setSubmenu:listMenu];
	
	// Company Menu
	var companyMenu = [[CPMenu alloc] initWithTitle:CPLocalizedString(@"Company",@"Company")],
    	companyMenuItem = [[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Company",@"Company") action:nil keyEquivalent:nil];
	[companyMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Home Page",@"Home Page")  action:@selector(accountList:)  keyEquivalent:@"H"]];
	[companyMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Company Snapshot",@"Company Snapshot") action:@selector(itemList:) keyEquivalent:@"S"]];
	[companyMenu addItem:[CPMenuItem separatorItem]];
	[companyMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Transaction Center",@"Transaction Center") action:@selector(customerList:) keyEquivalent:nil]];
	[companyMenu addItem:[CPMenuItem separatorItem]];
	[companyMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Setup Budget",@"Setup Budget") action:@selector(vendorList:) keyEquivalent:@"B"]];
	[companyMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"To Do List",@"To Do List") action:@selector(vendorList:) keyEquivalent:@"D"]];
	[companyMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Reminders",@"Reminders") action:@selector(vendorList:) keyEquivalent:@"R"]];
	[companyMenuItem setSubmenu:companyMenu];
	
	// Customers Menu
	var customerMenu = [[CPMenu alloc] initWithTitle:CPLocalizedString(@"Customers",@"Customers")],
    	customerMenuItem = [[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Customers",@"Customers") action:nil keyEquivalent:nil];
	[customerMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Customer Center",@"Customer Center")  action:@selector(accountList:)  keyEquivalent:@"A"]];
	[customerMenu addItem:[CPMenuItem separatorItem]];
	[customerMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Create Invoice",@"Create Invoice") action:@selector(itemList:) keyEquivalent:@"T"]];
	[customerMenuItem setSubmenu:customerMenu];
	
	// Vendors Menu
	var vendorMenu = [[CPMenu alloc] initWithTitle:CPLocalizedString(@"Vendors",@"Vendors")],
    	vendorMenuItem = [[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Vendors",@"Vendors") action:nil keyEquivalent:nil];
	[vendorMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Vendors Center",@"Vendors Center")  action:@selector(accountList:)  keyEquivalent:@"A"]];
	[vendorMenu addItem:[CPMenuItem separatorItem]];
	[vendorMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Enter Bills",@"Enter Bills") action:@selector(itemList:) keyEquivalent:@"T"]];
	[vendorMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Pay Bills",@"Pay Bills") action:@selector(itemList:) keyEquivalent:@"T"]];
	[vendorMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Pay Sale Taxes",@"Pay Sale Taxes") action:@selector(itemList:) keyEquivalent:@"T"]];
	[vendorMenuItem setSubmenu:vendorMenu];
	
	// Reports
	var reportMenu = [[CPMenu alloc] initWithTitle:CPLocalizedString(@"Report",@"Report")],
    	reportMenuItem = [[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Report",@"Report") action:nil keyEquivalent:nil];
	[reportMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Report Center",@"Report Center")  action:@selector(accountList:)  keyEquivalent:@"A"]];
	[reportMenu addItem:[CPMenuItem separatorItem]];
	[reportMenu addItem:[[CPMenuItem alloc] initWithTitle:CPLocalizedString(@"Company Finalcial",@"Company Financial") action:@selector(itemList:) keyEquivalent:@"T"]];
	[reportMenuItem setSubmenu:reportMenu];
	

	// Can't just addItem because of strut aftr Edit menu.
 	var theIndex = [myMenu indexOfItemWithTitle: @"Edit"];
	[myMenu insertItem:cloudBooksMenuItem atIndex: 0];
	[myMenu insertItem:listMenuItem atIndex: 1];
	[myMenu insertItem:companyMenuItem atIndex: 2];
	[myMenu insertItem:customerMenuItem atIndex: 3];
	[myMenu insertItem:vendorMenuItem atIndex: 4];
	[myMenu insertItem:reportMenuItem atIndex: 5];
	
	var theNewIndex  = [myMenu indexOfItemWithTitle: @"New" ];
 	var theOpenIndex = [myMenu indexOfItemWithTitle: @"Open"];
 	var theSaveIndex = [myMenu indexOfItemWithTitle: @"Save"];

	// N.B. You have to unwind the menus in reverse order.
	[myMenu removeItemAtIndex:theSaveIndex];
	[myMenu removeItemAtIndex:theOpenIndex];
	[myMenu removeItemAtIndex:theNewIndex];

	[self setMenuTarget:myMenu];
    [CPMenu setMenuBarVisible:YES];

}

- (void)setMenuTarget:(CPMenu)aMenu
{
	for (var i=0; i < [[aMenu itemArray] count]; i++)
	{
	    var item = [aMenu itemArray][i];
	    [item setTarget:self];
		
		if ([item hasSubmenu])
		{
			[self setMenuTarget:[item submenu]];			
		}

	}
}

// Action Selectors
- (void)backup:(CPMenuItem)sender
{
	var itemsWindow = [[AccountsWindow alloc] initWithContentView:_mainView];
	[itemsWindow openWindow:self reuseWindow:YES];
}

- (void)logoff:(CPMenuItem)sender
{
	alert("loggin off");
}

- (void)accountList:(CPMenuItem)sender
{	
	 var accountsWindow = [[AccountsWindow alloc] initWithContentView:_mainView];  
	[accountsWindow openWindow:self reuseWindow:YES];	
}


@end