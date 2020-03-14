#import "PowerDownButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <objc/runtime.h>

#define prefsDict [[NSUserDefaults alloc] initWithSuiteName:@"com.muirey03.powermoduleprefs"]

@interface FBSystemService : NSObject
+(instancetype)sharedInstance;
-(void)shutdownAndReboot:(BOOL)reboot;
@end

@implementation PowerDownButtonController
//this is what is called when the button is pressed, if you want to use it as a toggle, call [self buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict objectForKey:@"PowerDownConf"] boolValue])
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
