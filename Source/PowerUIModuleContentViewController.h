#import <UIKit/UIViewController.h>
#import <ControlCenterUIKit/CCUIContentModuleContentViewController-Protocol.h>
#import "RespringButtonController.h"
#import "RebootButtonController.h"
#import "SafemodeButtonController.h"
#import "UICacheButtonController.h"
#import "PowerDownButtonController.h"
#import "LockButtonController.h"

@class PMButtonViewController;

@interface PowerUIModuleContentViewController : UIViewController <CCUIContentModuleContentViewController>
//these are the dimensions of the module once its expanded
@property (nonatomic,readonly) CGFloat preferredExpandedContentHeight;
@property (nonatomic,readonly) CGFloat preferredExpandedContentWidth;
@property (nonatomic,readonly) BOOL providesOwnPlatter;

//these are the UIViewControllers for the buttons that are added to the module - each one inherits from PMButtonViewController
@property (nonatomic, strong) RespringButtonController* respringBtn;
@property (nonatomic, strong) RebootButtonController* rebootBtn;
@property (nonatomic, strong) UICacheButtonController* UICacheBtn;
@property (nonatomic, strong) SafemodeButtonController* safemodeBtn;
@property (nonatomic, strong) LockButtonController* lockBtn;
@property (nonatomic, strong) PowerDownButtonController* powerDownBtn;
@property (nonatomic, readonly) BOOL expanded;
@property (nonatomic, readonly) BOOL small;
@property (nonatomic, strong) NSMutableArray<PMButtonViewController*>* buttons;
-(instancetype)initWithSmallSize:(BOOL)small;
-(void)setupButtonViewController:(PMButtonViewController*)button title:(NSString*)title hidden:(BOOL)hidden;
-(void)layoutCollapsed;
-(void)layoutExpanded;
@end
