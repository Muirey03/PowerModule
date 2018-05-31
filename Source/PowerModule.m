#import "PowerModule.h"
#import "PowerUIModuleContentViewController.h"

@implementation PowerModule
//override the init to initialize the contentViewController (and the backgroundViewController if you have one)
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _contentViewController = [[PowerUIModuleContentViewController alloc]init];
	}

    return self;
}
@end
