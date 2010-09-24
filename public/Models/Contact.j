@import <CappuccinoResource/CRBase.j>

@implementation Contact : CappuccinoResource
{
	CPString title				@accessors;
	CPString first_name		@accessors;
	CPString middle				@accessors;
	CPString last_name		@accessors;
	CPString suffix				@accessors;
	CPString job_title		@accessors;
	
}

- (JSObject)attributes
{
	return {
		"contact": {
			"title":title,
			"first_name":first_name,
			"middle":middle,
			"last_name":last_name,
			"suffix":suffix,
			"job_title":job_title
		}
	};
}