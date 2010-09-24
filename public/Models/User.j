@import <CappuccinoResource/CRBase.j>

@implementation User : CappuccinoResource
{
	CPString firstname	@accessors;
	CPString lastname		@accessors;
	CPString username		@accessors;
	CPString password		@accessors;
}

- (JSObject)attributes
{
	return {
		"user": {
			"firstname":firstname,
			"lastname":lastname,
			"username":username,
			"password":password
		}
	};
}