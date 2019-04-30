#import "PowerUIModuleContentViewController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButtonViewController.h>
#import "RespringButtonController.h"
#import "RebootButtonController.h"
#import "SafemodeButtonController.h"
#import "UICacheButtonController.h"
#import "PowerDownButtonController.h"
#import "LockButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>

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
        [[self respringBtn] setTitle:@"Respring"];
        [[self respringBtn] setLabelsVisible:NO];
        [[self respringBtn] setIsExpanded:NO];
        [self addChildViewController:[self respringBtn]];

        //initialize UICacheBtn
        [self setUICacheBtn:[[UICacheButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"UICache" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self UICacheBtn] setEnabled:YES];
        [[self UICacheBtn] setTitle:@"UICache"];
        [[self UICacheBtn] setLabelsVisible:NO];
        [[self UICacheBtn] setIsExpanded:NO];
        [self addChildViewController:[self UICacheBtn]];

        //initialize rebootBtn
        [self setRebootBtn:[[RebootButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Reboot" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self rebootBtn] setEnabled:YES];
        [[self rebootBtn] setTitle:@"Reboot"];
        [[self rebootBtn] setLabelsVisible:NO];
        [[self rebootBtn] setIsExpanded:NO];
        [self addChildViewController:[self rebootBtn]];

        //initialize safemodeBtn
        [self setSafemodeBtn:[[SafemodeButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Safemode" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self safemodeBtn] setEnabled:YES];
        [[self safemodeBtn] setTitle:@"Safemode"];
        [[self safemodeBtn] setLabelsVisible:NO];
        [[self safemodeBtn] setIsExpanded:NO];
        [self addChildViewController:[self safemodeBtn]];

        //initialize powerDownBtn
        [self setPowerDownBtn:[[PowerDownButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Power" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self powerDownBtn] setEnabled:YES];
        [[self powerDownBtn] setTitle:@"Power down"];
        [[self powerDownBtn] setLabelsVisible:NO];
        [[self powerDownBtn] setIsExpanded:NO];
        [self addChildViewController:[self powerDownBtn]];

        //initialize lockBtn
        [self setLockBtn:[[LockButtonController alloc]initWithGlyphImage:[UIImage imageNamed:@"Lock" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] highlightColor:[UIColor greenColor] useLightStyle:YES]];
        [[self lockBtn] setEnabled:YES];
        [[self lockBtn] setTitle:@"Lock screen"];
        [[self lockBtn] setLabelsVisible:NO];
        [[self lockBtn] setIsExpanded:NO];
        [self addChildViewController:[self lockBtn]];
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
        _preferredExpandedContentWidth = [self mWidth] * 2.05;
        _preferredExpandedContentHeight = [self preferredExpandedContentWidth] * 1.4;

        if (![self isExpanded])
        {
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

            //Place powerDownBtn:
            [[self powerDownBtn] setMWidth:[self mWidth]];
            [self.view addSubview:[self powerDownBtn].view];
            [self powerDownBtn].view.hidden = YES;

            //Place lockBtn:
            [[self lockBtn] setMWidth:[self mWidth]];
            [self.view addSubview:[self lockBtn].view];
            [self lockBtn].view.hidden = YES;
        }
    }
}

//gets the width of the module and store it in mWidth
-(void)getWidth
{
    [self setMWidth:self.view.bounds.size.width];
}

//called before transitioning to the expanded content mode
-(void)willTransitionToExpandedContentMode:(BOOL)expanded
{
    [[self respringBtn] setIsExpanded:expanded];
    [[self UICacheBtn] setIsExpanded:expanded];
    [[self safemodeBtn] setIsExpanded:expanded];
    [[self rebootBtn] setIsExpanded:expanded];
    [[self lockBtn] setIsExpanded:expanded];
    [[self powerDownBtn] setIsExpanded:expanded];

    [self setIsExpanded:expanded];

    //the width of each button
    CGFloat bWidth = [self respringBtn].view.frame.size.width;
    if (expanded)
    {
        //Place lockBtn:
        [[self lockBtn] setMWidth:0];
        [self.view addSubview:[self lockBtn].view];

        //Place powerDownBtn:
        [[self powerDownBtn] setMWidth:0];
        [self.view addSubview:[self powerDownBtn].view];

        //the width of each CCUILabeledRoundButton
        CGFloat bLWidth = bWidth * 2.48;
        //this is the smaller distance (from the left of the module to the left of the top-left button)
        CGFloat leftF = ([self preferredExpandedContentWidth] - (2 * bLWidth)) / 3;
        //this is the longer distance (from the left of the module to the left of the top-right button)
        CGFloat rightF = [self preferredExpandedContentWidth] - leftF - bLWidth;
        //this is the distance from the top for the first row
        CGFloat topF1 = ([self preferredExpandedContentHeight] - (3 * bWidth)) / 7;
        //this is the distance from the top for the second row
        CGFloat topF2 = (topF1 * 3) + bWidth;
        //this is the distance from the top for the second row
        CGFloat topF3 = (topF1 * 5) + (bWidth * 2);

        [self respringBtn].view.frame = CGRectMake(leftF, topF1, bLWidth, bWidth + topF1);
        [self UICacheBtn].view.frame = CGRectMake(rightF, topF1, bLWidth, bWidth + topF1);
        [self safemodeBtn].view.frame = CGRectMake(leftF, topF2, bLWidth, bWidth + topF1);
        [self rebootBtn].view.frame = CGRectMake(rightF, topF2, bLWidth, bWidth + topF1);
        [self powerDownBtn].view.frame = CGRectMake(leftF, topF3, bLWidth, bWidth + topF1);
        [self lockBtn].view.frame = CGRectMake(rightF, topF3, bLWidth, bWidth + topF1);

        [self powerDownBtn].view.hidden = NO;
        [self lockBtn].view.hidden = NO;
    }
    else
    {
        [[[self respringBtn] buttonContainer] buttonView].frame = CGRectMake(0, 0, bWidth, bWidth);
        [[[self UICacheBtn] buttonContainer] buttonView].frame = CGRectMake(0, 0, bWidth, bWidth);
        [[[self safemodeBtn] buttonContainer] buttonView].frame = CGRectMake(0, 0, bWidth, bWidth);
        [[[self rebootBtn] buttonContainer] buttonView].frame = CGRectMake(0, 0, bWidth, bWidth);
        [[[self lockBtn] buttonContainer] buttonView].frame = CGRectMake(0, 0, bWidth, bWidth);
        [[[self powerDownBtn] buttonContainer] buttonView].frame = CGRectMake(0, 0, bWidth, bWidth);

        [self powerDownBtn].view.hidden = YES;
        [self lockBtn].view.hidden = YES;
    }

    [[self respringBtn] setLabelsVisible:expanded];
    [[self UICacheBtn] setLabelsVisible:expanded];
    [[self safemodeBtn] setLabelsVisible:expanded];
    [[self rebootBtn] setLabelsVisible:expanded];
    [[self lockBtn] setLabelsVisible:expanded];
    [[self powerDownBtn] setLabelsVisible:expanded];
}
@end
