#import "RebootButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <objc/runtime.h>

#define prefsDict [[NSUserDefaults alloc] initWithSuiteName:@"com.muirey03.powermoduleprefs"]

@interface FBSystemService : NSObject
+(instancetype)sharedInstance;
-(void)shutdownAndReboot:(BOOL)reboot;
@end

@implementation RebootButtonController
//this is what is called when the button is pressed, if you want to use it as a toggle, call [super buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict objectForKey:@"RebootConf"] boolValue])
    {
        UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"Reboot?" message:@"Are you sure you want to reboot?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
        {
            [self reboot];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [confirmation addAction:actionOK];
        [confirmation addAction:cancel];
        [self presentViewController:confirmation animated:YES completion:nil];
    }
    else
    {
        [self reboot];
    }
}

-(void)reboot
{
    if ([[prefsDict objectForKey:@"rebootAction"] isEqualToString:@"reboot"])
    {
        [[objc_getClass("FBSystemService") sharedInstance] shutdownAndReboot:YES];
    }
    else
    {
        pid_t pid;
        int status;
        const char* args[] = {"mobileldrestart", NULL};
        posix_spawn(&pid, "/usr/bin/mobileldrestart", NULL, NULL, (char* const*)args, NULL);
        waitpid(pid, &status, WEXITED);
    }
}
@end
