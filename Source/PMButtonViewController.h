#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>

@interface PMButtonViewController : CCUILabeledRoundButtonViewController
@property (nonatomic, strong) NSLayoutConstraint* widthConstraint;
@property (nonatomic, strong) NSLayoutConstraint* heightConstraint;
@property (nonatomic, strong) NSLayoutConstraint* centerXConstraint;
@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, assign) CGFloat collapsedAlpha;
@end
