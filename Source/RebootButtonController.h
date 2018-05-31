#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface RebootButtonController : CCUILabeledRoundButtonViewController
//the width of the module, set by the moduleViewController in it's viewDidLoadSubview method
@property CGFloat mWidth;

//reboot the device
-(void)reboot;
@end
