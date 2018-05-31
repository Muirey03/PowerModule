#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface UICacheButtonController : CCUILabeledRoundButtonViewController
//the width of the module, set by the moduleViewController in it's viewDidLoadSubview method
@property CGFloat mWidth;

//runs uicache
-(void)UICache;
@end
