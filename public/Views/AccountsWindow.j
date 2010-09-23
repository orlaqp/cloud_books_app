@import "WindowBase.j";

tableTestDragType = @"CPTableViewTestDragType";

@implementation AccountsWindow : WindowBase
{
	 CPTableView 	tableView;
    CPImage     		iconImage;
    CPArray     		dataSet1;    
	CPSplitView 	verticalSplitter;
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
		//[self createAccountsTableView];		
		[self createSplitter];
	}	
	return self;	
}

- (void)createSplitter
{
	verticalSplitter = [[CPSplitView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([_theContentView bounds]), CGRectGetHeight([_theContentView bounds]))];
	[verticalSplitter setDelegate:self];
	[verticalSplitter setVertical:YES]; 
	[verticalSplitter setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
	[verticalSplitter setIsPaneSplitter:YES];
	[_theContentView addSubview:verticalSplitter];
	
	var leftView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 200, CGRectGetHeight([verticalSplitter bounds]))];
	[leftView setAutoresizingMask:CPViewHeightSizable ]; 
	var rightView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([verticalSplitter bounds]) - 200, CGRectGetHeight([verticalSplitter bounds]))];
	[rightView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 

	[verticalSplitter addSubview:leftView];
	[verticalSplitter addSubview:rightView];
	
	[self showContactsGrid: leftView];
}

- (void)showContactsGrid:(CPView)aView
{

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
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    var iconView = [[CPImageView alloc] initWithFrame:CGRectMake(16,16,0,0)];
    [iconView setImageScaling:CPScaleNone];
    var iconColumn = [[CPTableColumn alloc] initWithIdentifier:"icons"];
    [iconColumn setWidth:32.0];
    [iconColumn setMinWidth:32.0];
    [iconColumn setDataView:iconView];
    [tableView addTableColumn:iconColumn];
    iconImage = [[CPImage alloc] initWithContentsOfFile:"http://cappuccino.org/images/favicon.png" size:CGSizeMake(16,16)];
	
	 var desc = [CPSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
	 
	 var nameColumn = [[CPTableColumn alloc] initWithIdentifier:@"Contact_Name"];
	[nameColumn setSortDescriptorPrototype:desc];
	[[nameColumn headerView] setStringValue:@"Contact Name"];

	[nameColumn setMinWidth:10.0];
	[nameColumn setMaxWidth:200.0];
	[nameColumn setWidth:150.0];
	
	[nameColumn setEditable:YES];
	[tableView addTableColumn:nameColumn];
	
	/*
    for (var i = 1; i <= 2; i++)
    {
        var column = [[CPTableColumn alloc] initWithIdentifier:String(i)];
        [column setSortDescriptorPrototype:desc];
        [[column headerView] setStringValue:"Number " + i];

        [column setMinWidth:10.0];
        [column setMaxWidth:110.0];
        [column setWidth:100.0];
        
        [column setEditable:YES];
        [tableView addTableColumn:column];
    }
	*/

    var scrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([aView bounds]), CGRectGetHeight([aView bounds]))];
   
    [scrollView setDocumentView:tableView];
    [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    [aView addSubview:scrollView];

    //[_theWindow orderFront:self];
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