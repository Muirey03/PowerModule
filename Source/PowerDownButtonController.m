#import "PowerDownButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <objc/runtime.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.muirey03.powermoduleprefs.plist"
#define prefsDict [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH]

@interface FBSystemService : NSObject
+(id)sharedInstance;                        //existing presence of object
-(void)shutdownAndReboot:(BOOL)arg1;    //shutting down with the option to reboot (the boolean value)
-(void)exitAndRelaunch:(BOOL)arg1;        //restart the FrontBoard process (thus restarting SpringBoard as well; the boolean value has no change, the process restarts anyway)
-(void)nonExistantMethod;                    //fake method to crash in a safe way, loading SafeMode
@end

@implementation PowerDownButtonController
//here is where we set the width of the CCUILabeledRoundButton - the width of CCUIRoundButton is set automatically so we just use that to set the width of the CCUILabeledRoundButton
-(void)viewDidLayoutSubviews
{
    //this will be true if we are in the collapsed view, we don't want to position the buttons here if we are in the expanded view - that will be done in willTransitionToExpandedContentMode
    if (![self isExpanded] && [self mWidth] != 0)
    {
        //get the width of the CCUIRoundButton
        CGFloat bWidth = [[self buttonContainer] buttonView].frame.size.width;
        //this is the smaller distance (from the left of the module to the left of the top-left button)
        CGFloat leftF = ([self mWidth] - (2 * bWidth)) / 3;
        //this is the longer distance (from the left of the module to the left of the top-right button)
        CGFloat rightF = [self mWidth] - leftF - bWidth;

        //each button is positioned differently - this one is the top-right - we also need to set the width here
        self.view.frame = CGRectMake(rightF, [self mWidth], bWidth, bWidth);
    }
}

//this is what is called when the button is pressed, if you want to use it as a toggle, call [self buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict valueForKey:@"PowerDownConf"] boolValue])
    {
        UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"Power down?" message:@"Are you sure you want to power down?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
        {
            [self PowerDown];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [confirmation addAction:actionOK];
        [confirmation addAction:cancel];
        [self presentViewController:confirmation animated:YES completion:nil];
    }
    else
    {
        [self PowerDown];
    }
}

-(void)PowerDown
{
    [[objc_getClass("FBSystemService") sharedInstance] shutdownAndReboot:NO];
}
@end
