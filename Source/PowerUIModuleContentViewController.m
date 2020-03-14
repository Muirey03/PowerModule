#import "PowerUIModuleContentViewController.h"
#import "PMButtonViewController.h"
#import "RespringButtonController.h"
#import "RebootButtonController.h"
#import "SafemodeButtonController.h"
#import "UICacheButtonController.h"
#import "PowerDownButtonController.h"
#import "LockButtonController.h"

@implementation PowerUIModuleContentViewController
-(instancetype)initWithSmallSize:(BOOL)small
{
    _small = small;
    return [self init];
}

//This is where you initialize any controllers for objects from ControlCenterUIKit
-(instancetype)initWithNibName:(NSString*)name bundle:(NSBundle*)bundle
{
    self = [super initWithNibName:name bundle:bundle];
    if (self)
    {
        _buttons = [NSMutableArray new];
        self.view.clipsToBounds = YES;

        /* Initialize PMButtonViewControllers here: */
        //initialize respringBtn
        _respringBtn = [[RespringButtonController alloc] initWithGlyphImage:[UIImage imageNamed:@"Respring" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES];
        [self setupButtonViewController:_respringBtn title:@"Respring" hidden:NO];

        //initialize UICacheBtn
        _UICacheBtn = [[UICacheButtonController alloc] initWithGlyphImage:[UIImage imageNamed:@"UICache" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES];
        [self setupButtonViewController:_UICacheBtn title:@"UICache" hidden:_small];

        //initialize rebootBtn
        _rebootBtn = [[RebootButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Reboot" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES];
        [self setupButtonViewController:_rebootBtn title:@"Reboot" hidden:_small];

        //initialize safemodeBtn
        _safemodeBtn = [[SafemodeButtonController alloc] initWithGlyphImage:[UIImage imageNamed:@"Safemode" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES];
        [self setupButtonViewController:_safemodeBtn title:@"Safemode" hidden:_small];

        //initialize powerDownBtn
        _powerDownBtn = [[PowerDownButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Power" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES];
        [self setupButtonViewController:_powerDownBtn title:@"Power Down" hidden:YES];

        //initialize lockBtn
        _lockBtn = [[LockButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Lock" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES];
        [self setupButtonViewController:_lockBtn title:@"Lock Screen" hidden:YES];
	}
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //calculate expanded size:
    _preferredExpandedContentWidth = [UIScreen mainScreen].bounds.size.width * 0.856;
    _preferredExpandedContentHeight = _preferredExpandedContentWidth * 1.4;
}

-(void)setupButtonViewController:(PMButtonViewController*)button title:(NSString*)title hidden:(BOOL)hidden
{
    button.title = title;
    button.labelsVisible = hidden;
    button.view.alpha = (CGFloat)!hidden;
    button.collapsedAlpha = button.view.alpha;
    if ([button respondsToSelector:@selector(setUseAlternateBackground:)])
        button.useAlternateBackground = NO;
    [self addChildViewController:button];
    [self.view addSubview:button.view];
    [_buttons addObject:button];

    //initialise default constraints:
    button.view.translatesAutoresizingMaskIntoConstraints = NO;
    button.widthConstraint = [button.view.widthAnchor constraintEqualToConstant:0];
    button.heightConstraint = [button.view.heightAnchor constraintEqualToConstant:0];
    button.centerXConstraint = [button.view.centerXAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    button.topConstraint = [button.view.topAnchor constraintEqualToAnchor:self.view.topAnchor];
    [NSLayoutConstraint activateConstraints:@[button.widthConstraint, button.heightConstraint, button.centerXConstraint, button.topConstraint]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //perform initial layout:
    [self layoutCollapsed];
}

-(void)layoutCollapsed
{
    //calculate constants needed for layout:
    CGSize size = self.view.frame.size;
    CGFloat btnSize = [_respringBtn.view sizeThatFits:size].width;
    CGFloat padding = (size.width - (_small ? 1 : 2) * btnSize) / (_small ? 2 : 3);
    CGFloat smallCenter = padding + btnSize / 2;

    //resize buttons:
    for (PMButtonViewController* btn in _buttons)
    {
        btn.view.alpha = btn.collapsedAlpha;
        btn.labelsVisible = NO;
        btn.widthConstraint.constant = btnSize, btn.heightConstraint.constant = btnSize;
    }

    //reposition buttons:
    _respringBtn.centerXConstraint.constant = smallCenter;
    _respringBtn.topConstraint.constant = padding;
    _UICacheBtn.centerXConstraint.constant = size.width - smallCenter;
    _UICacheBtn.topConstraint.constant = padding;
    _rebootBtn.centerXConstraint.constant = size.width - smallCenter;
    _rebootBtn.topConstraint.constant = 2 * padding + btnSize;
    _safemodeBtn.centerXConstraint.constant = smallCenter;
    _safemodeBtn.topConstraint.constant = 2 * padding + btnSize;
    _powerDownBtn.centerXConstraint.constant = smallCenter;
    _powerDownBtn.topConstraint.constant = 3 * padding + 2 * btnSize;
    _lockBtn.centerXConstraint.constant = size.width - smallCenter;
    _lockBtn.topConstraint.constant = 3 * padding + 2 * btnSize;
}

-(void)layoutExpanded
{
    //calculate constants needed for layout:
    CGSize size = self.view.frame.size;
    CGFloat oldBtnWidth = _respringBtn.view.intrinsicContentSize.width;
    CGFloat ySpacing = (size.height - 3 * oldBtnWidth) / 7;
    CGFloat xOffset = (size.width - 2 * oldBtnWidth) / 4;
    CGFloat xCenterLeft = xOffset + oldBtnWidth / 2;
    CGFloat xCenterRight = size.width - xCenterLeft;
    CGFloat newBtnHeight = (size.height - 4 * ySpacing) / 3;

    //resize buttons:
    for (PMButtonViewController* btn in _buttons)
    {
        btn.view.alpha = 1;
        btn.labelsVisible = YES;
        btn.widthConstraint.constant = (size.width / 2), btn.heightConstraint.constant = newBtnHeight;
    }

    //reposition buttons:
    _respringBtn.centerXConstraint.constant = xCenterLeft;
    _respringBtn.topConstraint.constant = ySpacing;
    _UICacheBtn.centerXConstraint.constant = xCenterRight;
    _UICacheBtn.topConstraint.constant = ySpacing;
    _rebootBtn.centerXConstraint.constant = xCenterRight;
    _rebootBtn.topConstraint.constant = 2 * ySpacing + newBtnHeight;
    _safemodeBtn.centerXConstraint.constant = xCenterLeft;
    _safemodeBtn.topConstraint.constant = 2 * ySpacing + newBtnHeight;
    _powerDownBtn.centerXConstraint.constant = xCenterLeft;
    _powerDownBtn.topConstraint.constant = 3 * ySpacing + 2 * newBtnHeight;
    _lockBtn.centerXConstraint.constant = xCenterRight;
    _lockBtn.topConstraint.constant = 3 * ySpacing + 2 * newBtnHeight;
}

-(void)willTransitionToExpandedContentMode:(BOOL)expanded
{
    //keep track of the expansion state:
    _expanded = expanded;
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        if (_expanded)
            [self layoutExpanded];
        else
            [self layoutCollapsed];
        //force animated constraint updates:
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(BOOL)_canShowWhileLocked
{
	return YES;
}
@end
