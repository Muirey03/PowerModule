#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface SafemodeButtonController : CCUILabeledRoundButtonViewController
//the width of the module, set by the moduleViewController in it's viewDidLoadSubview method
@property CGFloat mWidth;

//sends the device into safemode
-(void)safemode;
@end
