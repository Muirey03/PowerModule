#import "PowerModule.h"
#import "PowerUIModuleContentViewController.h"
#import <ControlCenterUIKit/ControlCenterUI-Structs.h>
#import <objc/runtime.h>

@implementation PowerModule
//override the init to initialize the contentViewController (and the backgroundViewController if you have one)
-(instancetype)init
{
    if ((self = [super init]))
    {
        _contentViewController = [[PowerUIModuleContentViewController alloc] initWithSmallSize:self.smallSize];
	}
    return self;
}

-(CCUILayoutSize)moduleSizeForOrientation:(int)orientation
{
    return self.smallSize ? (CCUILayoutSize){1, 1} : (CCUILayoutSize){2, 2};
}

-(BOOL)smallSize
{
    return [[[[NSUserDefaults alloc] initWithSuiteName:@"com.muirey03.powermoduleprefs"] objectForKey:@"moduleSize"] isEqualToString:@"1x1"];
}
@end
