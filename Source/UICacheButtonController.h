#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface UICacheButtonController : CCUILabeledRoundButtonViewController
//the width of the module, set by the moduleViewController in it's viewDidLoadSubview method
@property CGFloat mWidth;

@property BOOL isExpanded;
//runs uicache
-(void)UICache;
@end
