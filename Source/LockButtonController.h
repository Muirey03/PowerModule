#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface LockButtonController : CCUILabeledRoundButtonViewController
//the width of the module, set by the moduleViewController in it's viewDidLoadSubview method
@property CGFloat mWidth;

@property BOOL isExpanded;
//locks device
-(void)Lock;
@end
