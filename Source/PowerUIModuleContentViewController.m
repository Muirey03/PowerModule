#import "PowerUIModuleContentViewController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>
#import "RespringButtonController.h"
#import "RebootButtonController.h"
#import "SafemodeButtonController.h"
#import "UICacheButtonController.h"

@implementation PowerUIModuleContentViewController
//This is where you initialize any controllers for objects from ControlCenterUIKit
-(id)initWithNibName:(id)arg1 bundle:(id)arg2
{
    self = [super initWithNibName:arg1 bundle:arg2];
    if (self)
    {
        /* Initialize CCUILabeledRoundButtonViewControllers here: */

        //initialize respringBtn
        [self setRespringBtn:[[RespringButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Respring" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self respringBtn] setEnabled:YES];
        [self addChildViewController:[self respringBtn]];

        //initialize UICacheBtn
        [self setUICacheBtn:[[UICacheButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"UICache" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self UICacheBtn] setEnabled:YES];
        [self addChildViewController:[self UICacheBtn]];

        //initialize rebootBtn
        [self setRebootBtn:[[RebootButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Reboot" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self rebootBtn] setEnabled:YES];
        [self addChildViewController:[self rebootBtn]];

        //initialize safemodeBtn
        [self setSafemodeBtn:[[SafemodeButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Safemode" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self safemodeBtn] setEnabled:YES];
        [self addChildViewController:[self safemodeBtn]];
	}

    return self;
}

//This is where you add your subviews (this is the first method when self.view.bounds.size.width doesn't return 0)
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    if ([self respringBtn].view)
    {
        //get the width of the module and store it in mWidth
        [self getWidth];

        //set the preferredExpandedContentWidth and height here, or elsewhere, I'm doing it here because I need the mWidth
        _preferredExpandedContentHeight = [self mWidth];
        _preferredExpandedContentWidth = [self mWidth];

        //Place respringBtn:
        [[self respringBtn] setMWidth:[self mWidth]];
        [self.view addSubview:[self respringBtn].view];

        //Place rebootBtn:
        [[self rebootBtn] setMWidth:[self mWidth]];
        [self.view addSubview:[self rebootBtn].view];

        //Place safemodeBtn:
        [[self safemodeBtn] setMWidth:[self mWidth]];
        [self.view addSubview:[self safemodeBtn].view];

        //Place UICacheBtn:
        [[self UICacheBtn] setMWidth:[self mWidth]];
        [self.view addSubview:[self UICacheBtn].view];
    }
}

//gets the width of the module and store it in mWidth
-(void)getWidth
{
    [self setMWidth:self.view.bounds.size.width];
}
@end
