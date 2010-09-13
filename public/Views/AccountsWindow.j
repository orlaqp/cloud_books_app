@import "WindowBase.j";

tableTestDragType = @"CPTableViewTestDragType";

@implementation AccountsWindow : WindowBase
{
	 CPTableView 	tableView;
    CPImage     		iconImage;
    CPArray     		dataSet1;    
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
		[self createAccountsTableView];		
	}	
	return self;	
}

- (void)createAccountsTableView
{

	dataSet1 = []
    
    for(var i = 1; i < 100; i++)
    {
        dataSet1[i - 1] = [CPNumber numberWithInt:i];       
    }

	tableView = [[CPTableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 500.0, 500.0)];

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
    for (var i = 1; i <= 2; i++)
    {
        var column = [[CPTableColumn alloc] initWithIdentifier:String(i)];
        [column setSortDescriptorPrototype:desc];
        [[column headerView] setStringValue:"Number " + i];

        [column setMinWidth:50.0];
        [column setMaxWidth:500.0];
        [column setWidth:200.0];
        
        [column setEditable:YES];
        [tableView addTableColumn:column];
    }

    var scrollView = [[CPScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([_theContentView bounds]), CGRectGetHeight([_theContentView bounds]))];
   
    [scrollView setDocumentView:tableView];
    [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    [_theContentView addSubview:scrollView];

    [_theWindow orderFront:self];
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

- (BOOL)tableView:(CPTableView)aTableView shouldEditTableColumn:(CPTableColumn)tableColumn row:(int)row
{
    if(aTableView === tableView)
        return YES;
    else
        return NO;
}

@end