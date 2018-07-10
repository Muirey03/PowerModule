#import "LockButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <objc/runtime.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.muirey03.powermoduleprefs.plist"
#define prefsDict [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH]

@interface SpringBoard
-(void)_simulateLockButtonPress;
@end

@implementation LockButtonController
//here is where we set the width of the CCUILabeledRoundButton - the width of CCUIRoundButton is set automatically so we just use that to set the width of the CCUILabeledRoundButton
-(void)viewDidLayoutSubviews
{
    //dirty ass fix for the background color being wrong:
    int i = 0;
    for (UIView* v in self.buttonContainer.buttonView.subviews)
    {
        if ([v isMemberOfClass:[NSClassFromString(@"MTMaterialView") class]])
        {
            v.alpha = i ? 0 : v.alpha;
            i++;
        }
    }
}

//this is what is called when the button is pressed, if you want to use it as a toggle, call [self buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict valueForKey:@"LockConf"] boolValue])
    {
        UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"Lock device?" message:@"Are you sure you want to go to the lockscreen?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
        {
            [self Lock];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [confirmation addAction:actionOK];
        [confirmation addAction:cancel];
        [self presentViewController:confirmation animated:YES completion:nil];
    }
    else
    {
        [self Lock];
    }
}

-(void)Lock
{
    SpringBoard *sb = (SpringBoard *)[objc_getClass("SpringBoard") sharedApplication];
    if (sb)
    {
        [sb _simulateLockButtonPress];
    }
}
@end
