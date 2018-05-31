#import <UIKit/UIViewController.h>
#import <ControlCenterUIKit/CCUIContentModuleContentViewController-Protocol.h>
#import "RespringButtonController.h"
#import "RebootButtonController.h"
#import "SafemodeButtonController.h"
#import "UICacheButtonController.h"

@interface PowerUIModuleContentViewController : UIViewController <CCUIContentModuleContentViewController>
//these are the dimensions of the module once its expanded
@property (nonatomic,readonly) CGFloat preferredExpandedContentHeight;
@property (nonatomic,readonly) CGFloat preferredExpandedContentWidth;

//width of the module
@property CGFloat mWidth;

//these are the UIViewControllers for the buttons that are added to the module - each one inherits from CCUILabeledRoundButtonViewController
@property RespringButtonController* respringBtn;
@property RebootButtonController* rebootBtn;
@property UICacheButtonController* UICacheBtn;
@property SafemodeButtonController* safemodeBtn;

//this is what I'm using to set mWidth
-(void)getWidth;
@end
