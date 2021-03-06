@import "WindowBase.j";
@import "../Models/Contact.j";
@import "ContactDetails.j";
//@import "../CustomControls/CustomCPToolbar.j"

var tableTestDragType = @"CPTableViewTestDragType";
var CreateContactToolbarItemIdentifier = 'AddContactToolbarItemIdentifier',
	      EditContactToolbarItemIdentifier = 'EditContactToolbarItemIdentifier',
		  RemoveContactToolbarItemIdentifer = 'RemoveContactToolbarItemIdentifier',
		  SearchContactToolbarItemIdentifier = 'SearchContactToolbarItemIdentifier';

@implementation AddressBook : WindowBase
{
    CPToolbar				toolbar;
	CPSearchField        searchField;
	CPTableView 	       tableView;
    CPImage     		       iconImage;
    CPArray     		       dataSet1;    
	CPSplitView 	       verticalSplitter;	
	CPView				       searchFieldContainer;
	CPView				       splitterContainer;	
}

- (id)initWithContentView:(CPView)aView
{	
	// Set Size and Position
    var windowHeight = 350.0;
    var windowWidth = 600.0;

    _theWindow = [[CPWindow alloc] initWithContentRect:CGRectMake(0, 0, windowWidth, windowHeight) styleMask: CPTitledWindowMask | CPClosableWindowMask | CPMiniaturizableWindowMask | CPResizableWindowMask ],
        _theContentView = [_theWindow contentView];

    [_theWindow setFrameOrigin:CGPointMake((CGRectGetWidth([aView bounds]) - windowWidth) / 2.0,
                 (CGRectGetHeight([aView bounds]) - windowHeight) / 2.0)];

	[_theWindow setTitle:@"Account List"];

	 self = [super initWithWindow:_theWindow];

    if (self)
	{
		// Load Contacts first
		[self loadContacts:@""];
		
		// Create Splitter View
		[self createToolbar];
		[self createLayout:_theContentView];
	}	
	return self;	
}

- (void)createToolbar
{
	toolbar = [[CPToolbar alloc] initWithIdentifier:"Photos"];
	//[toolbar setHeight:59];
	[toolbar setDelegate:self];
	[toolbar setVisible:YES];
	[_theWindow setToolbar:toolbar];
}

// Return an array of toolbar item identifier (all the toolbar items that may be present in the toolbar)
- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{
   return [CreateContactToolbarItemIdentifier, EditContactToolbarItemIdentifier, RemoveContactToolbarItemIdentifer, 
             CPToolbarFlexibleSpaceItemIdentifier, SearchContactToolbarItemIdentifier];
}

// Return an array of toolbar item identifier (the default toolbar items that are present in the toolbar)
- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{
   return [CreateContactToolbarItemIdentifier, EditContactToolbarItemIdentifier, RemoveContactToolbarItemIdentifer, 
             CPToolbarFlexibleSpaceItemIdentifier, SearchContactToolbarItemIdentifier];
}

- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)anItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag
{
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:anItemIdentifier];

    if (anItemIdentifier == SearchContactToolbarItemIdentifier)
    {
		searchField = [[CPSearchField alloc] initWithFrame:CPMakeRect(2,2,190,30)];       
        [searchField setRecentsAutosaveName:"autosave"];
        [searchField setTarget:self];
        [searchField setAction:@selector(updateFilter:)];
	    [searchField setPlaceholderString:@"type to search"];
        [searchField setAutoresizingMask:CPViewMinXMargin | CPViewMinYMargin | CPViewWidthSizable | CPViewHeightSizable ];
		
		[toolbarItem setView:searchField];
		[toolbarItem setMinSize:CGSizeMake(180, 32)];
	    [toolbarItem setMaxSize:CGSizeMake(180, 32)]; 		
    }
	else if (anItemIdentifier == CreateContactToolbarItemIdentifier)
	{	
	    var image = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/add_user.png" size:CGSizeMake(32.0, 32.0)],
            alternateImage = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/add_user.png" size:CGSizeMake(30.0, 30.0)];        
        [toolbarItem setLabel:@"Add Contact"];
        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:alternateImage];	
	}
	else if (anItemIdentifier == EditContactToolbarItemIdentifier)
	{	
	    var image = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/edit_user.png" size:CGSizeMake(32.0, 32.0)],
            alternateImage = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/edit_user.png" size:CGSizeMake(30.0, 30.0)];        
        [toolbarItem setLabel:@"Edit Contact"];
        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:alternateImage];	
	}
	else if (anItemIdentifier == RemoveContactToolbarItemIdentifer)
	{	
	    var image = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/remove_user.png" size:CGSizeMake(32.0, 32.0)],
            alternateImage = [[CPImage alloc] initWithContentsOfFile:@"/Resources/icons/remove_user.png" size:CGSizeMake(30.0, 30.0)];        
        [toolbarItem setLabel:@"Erase Contact"];
        [toolbarItem setImage:image];
        [toolbarItem setAlternateImage:alternateImage];	
	}
	else if (anItemIdentifier == RemoveContactToolbarItemIdentifer)
    {
    }
    
    return toolbarItem;
}

- (void) loadContacts:(CPString)aSearchCriteria
{
	var contacts = [Contact all];
}

- (void)createLayout:(CPView)aView
{
	// Containers
	splitterContainer = [[CPView alloc] initWithFrame:CPMakeRect(0,0,CGRectGetWidth([aView bounds]), CGRectGetHeight([aView bounds]))];
	[splitterContainer setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];	
	[aView addSubview:splitterContainer];
	
	[self createSplitterContainerControls:splitterContainer];
}

- (void)createSplitterContainerControls:(CPView)aView
{
	verticalSplitter = [[CPSplitView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([aView bounds]), CGRectGetHeight([aView bounds]))];
	[verticalSplitter setDelegate:self];
	[verticalSplitter setVertical:YES]; 
	[verticalSplitter setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
	[verticalSplitter setIsPaneSplitter:YES];
	[aView addSubview:verticalSplitter];
	
	var leftView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 200, CGRectGetHeight([verticalSplitter bounds]))];
	[leftView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
	var rightView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([verticalSplitter bounds]) - 200, CGRectGetHeight([verticalSplitter bounds]))];
	[rightView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 

	[verticalSplitter addSubview:leftView];
	[verticalSplitter addSubview:rightView];
	
	// Render left view
	[self renderLeftView:leftView];
	[self renderContactDetails:rightView];
}

- (void)renderContactDetails:(CPView)aView
{
	var contactDetails = [[ContactDetails alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth([aView bounds]), CGRectGetHeight([aView bounds]))];
	[aView addSubview:contactDetails];
}

- (void)renderLeftView:(CPView)aView
{

	// Table View
	dataSet1 = []
    
    for(var i = 1; i < 100; i++)
    {
        dataSet1[i - 1] = [CPNumber numberWithInt:i];       
    }

	tableView = [[CPTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];

    [tableView setAllowsMultipleSelection:YES];
    [tableView setAllowsColumnSelection:YES];
    [tableView setUsesAlternatingRowBackgroundColors:YES];
	//[tableView setAlternatingRowBackgroundColors:[[CPColor whiteColor], [CPColor colorWithHexString:@"e4e7ff"], [CPColor colorWithHexString:@"f4e7ff"]]];
    [tableView setGridStyleMask:CPTableViewSolidHorizontalGridLineMask | CPTableViewSolidVerticalGridLineMask];    
	[tableView setVerticalMotionCanBeginDrag:NO];
    [tableView setDraggingDestinationFeedbackStyle:CPTableViewDropOn];
    [tableView registerForDraggedTypes:[CPArray arrayWithObject:tableTestDragType]];
    [tableView setColumnAutoresizingStyle:CPTableViewLastColumnOnlyAutoresizingStyle];
	[tableView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    var iconView = [[CPImageView alloc] initWithFrame:CGRectMake(16,16,0,0)];
    [iconView setImageScaling:CPScaleNone];
    var iconColumn = [[CPTableColumn alloc] initWithIdentifier:"icons"];
    [iconColumn setWidth:32.0];
    [iconColumn setMinWidth:32.0];
    [iconColumn setDataView:iconView];
    [tableView addTableColumn:iconColumn];
    iconImage = [[CPImage alloc] initWithContentsOfFile:"/images/icons/generic_contact.jpg" size:CGSizeMake(16,16)];
	
	 var desc = [CPSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
	 
	 var nameColumn = [[CPTableColumn alloc] initWithIdentifier:@"Contact_Name"];
	[nameColumn setSortDescriptorPrototype:desc];
	[[nameColumn headerView] setStringValue:@"Contacts"];

	[nameColumn setMinWidth:10.0];
	[nameColumn setMaxWidth:200.0];
	[nameColumn setWidth:150.0];
	
	[nameColumn setEditable:YES];
	[tableView addTableColumn:nameColumn];
	
    var scrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(2, 2, CGRectGetWidth([aView bounds]), CGRectGetHeight([aView bounds]))];
   [scrollView setDocumentView:tableView];
    [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    [aView addSubview:scrollView];
	
    //[_theWindow orderFront:self];
}


- (void)updateFilter:(CPString)aString
{
	alert("updating filter");
}

- (int)numberOfRowsInTableView:(CPTableView)atableView
{
    return dataSet1.length;    
}

- (id)tableView:(CPTableView)aTableView objectValueForTableColumn:(CPTableColumn)aColumn row:(int)aRow
{
    if ([aColumn identifier] === "icons")
        return iconImage;
    
    if (aTableView === tableView)
        return String(dataSet1[aRow]);    
}

- (void)tableView:(CPTableView)aTableView sortDescriptorsDidChange:(CPArray)oldDescriptors
{
    CPLogConsole(_cmd + [oldDescriptors description]);
    
    var newDescriptors = [aTableView sortDescriptors];
    [(aTableView === tableView) ? dataSet1:dataSet2 sortUsingDescriptors:newDescriptors];
	[aTableView reloadData];
}

- (void)tableViewSelectionIsChanging:(CPNotification)aNotification
{
	CPLog.debug(@"changing! %@", [aNotification description]);
}

- (void)tableViewSelectionDidChange:(CPNotification)aNotification
{
	CPLog.debug(@"did change! %@", [aNotification description]);
}

- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    // if(aTableView === tableView)
    return YES;
    // else
    //    return NO;
}
- (BOOL)tableView:(CPTableView)aTableView writeRowsWithIndexes:(CPIndexSet)rowIndexes toPasteboard:(CPPasteboard)pboard
{
    // if (aTableView === tableView3)
    //    return NO;

    var data = [rowIndexes, [aTableView UID]];
    
    var encodedData = [CPKeyedArchiver archivedDataWithRootObject:data];
    [pboard declareTypes:[CPArray arrayWithObject:tableTestDragType] owner:self];
    [pboard setData:encodedData forType:tableTestDragType];
    
    return YES;
}

- (CPDragOperation)tableView:(CPTableView)aTableView 
                   validateDrop:(id)info 
                   proposedRow:(CPInteger)row 
                   proposedDropOperation:(CPTableViewDropOperation)operation
{

    [[aTableView window] orderFront:nil];

    if(aTableView === tableView)
        [aTableView setDropRow:row dropOperation:CPTableViewDropOn];
    else 
        [aTableView setDropRow:row dropOperation:CPTableViewDropAbove];
        
    return CPDragOperationMove;
}

- (BOOL)tableView:(CPTableView)aTableView acceptDrop:(id)info row:(int)row dropOperation:(CPTableViewDropOperation)operation
{    
    var pboard = [info draggingPasteboard],
        rowData = [pboard dataForType:tableTestDragType],
        tables = [tableView, tableView],
        dataSets = [dataSet1, dataSet1];   
    
    rowData = [CPKeyedUnarchiver unarchiveObjectWithData:rowData];
    
    var sourceIndexes = rowData[0],
        sourceTableUID = rowData[1];
     
    var index = (aTableView == tableView) ? 1 : 0;
        
    var destinationTable = tables[1 - index],
        sourceTable = tables[index],
        destinationDataSet = dataSets[1 - index],
        sourceDataSet = dataSets[index];

    if(operation | CPDragOperationMove)
    {
        if (sourceTableUID == [aTableView UID])
        {
            [destinationDataSet moveIndexes:sourceIndexes toIndex:row];
            [destinationTable reloadData];
            var destIndexes = [CPIndexSet indexSetWithIndexesInRange:CPMakeRange(row, [sourceIndexes count])];
            [destinationTable selectRowIndexes:destIndexes byExtendingSelection:NO];            
        }
        else
        {
            var destIndexes = [CPIndexSet indexSetWithIndexesInRange:CPMakeRange(row, [sourceIndexes count])];
            var sourceObjects = [sourceDataSet objectsAtIndexes:sourceIndexes];

            [destinationDataSet insertObjects:sourceObjects atIndexes:destIndexes];
            [destinationTable reloadData];
            [destinationTable selectRowIndexes:destIndexes byExtendingSelection:NO];
            
            [sourceDataSet removeObjectsAtIndexes:sourceIndexes];
            [sourceTable reloadData];
            [sourceTable selectRowIndexes:[CPIndexSet indexSet] byExtendingSelection:NO];                
        }
    }
        
    return YES;
}

@end