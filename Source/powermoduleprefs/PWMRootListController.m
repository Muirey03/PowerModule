#include "PWMRootListController.h"

@implementation PWMRootListController
-(NSArray*)specifiers
{
	if (!_specifiers)
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	return _specifiers;
}

-(void)creatorMethod
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/Muirey03"]];
}

-(void)creditsMethod
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/user/thecoderkiller"]];
}
@end
