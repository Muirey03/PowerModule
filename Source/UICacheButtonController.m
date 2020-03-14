#import "UICacheButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <sys/wait.h>

#define prefsDict [[NSUserDefaults alloc] initWithSuiteName:@"com.muirey03.powermoduleprefs"]

@implementation UICacheButtonController
//this is what is called when the button is pressed, if you want to use it as a toggle, call [self buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict objectForKey:@"UICacheConf"] boolValue])
    {
        UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"UICache?" message:@"Are you sure you want to run uicache?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
        {
            [self UICache];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [confirmation addAction:actionOK];
        [confirmation addAction:cancel];
        [self presentViewController:confirmation animated:YES completion:nil];
    }
    else
    {
        [self UICache];
    }
}

-(void)UICache
{
    pid_t pid;
    int status;
    const char* args[] = {"uicache", NULL};
    posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}
@end
