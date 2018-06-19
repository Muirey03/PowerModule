#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface PowerDownButtonController : CCUILabeledRoundButtonViewController
//the width of the module, set by the moduleViewController in it's viewDidLoadSubview method
@property CGFloat mWidth;

@property BOOL isExpanded;
//powers the device down
-(void)PowerDown;
@end
