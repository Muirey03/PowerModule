#import "LockButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <objc/runtime.h>

#define prefsDict [[NSUserDefaults alloc] initWithSuiteName:@"com.muirey03.powermoduleprefs"]

@interface SpringBoard
-(void)_simulateLockButtonPress;
@end

@implementation LockButtonController
//this is what is called when the button is pressed, if you want to use it as a toggle, call [self buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict objectForKey:@"LockConf"] boolValue])
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
    SpringBoard* sb = (SpringBoard*)[objc_getClass("SpringBoard") sharedApplication];
    [sb _simulateLockButtonPress];
}
@end
