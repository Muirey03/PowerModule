#import "RespringButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>

#define prefsDict [[NSUserDefaults alloc] initWithSuiteName:@"com.muirey03.powermoduleprefs"]

@implementation RespringButtonController
//this is what is called when the button is pressed, if you want to use it as a toggle, call [super buttonTapped:arg1];
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict objectForKey:@"RespringConf"] boolValue])
    {
        UIAlertController* confirmation = [UIAlertController alertControllerWithTitle:@"Respring?" message:@"Are you sure you want to respring?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action)
        {
            [self respring];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [confirmation addAction:actionOK];
        [confirmation addAction:cancel];
        [self presentViewController:confirmation animated:YES completion:nil];
    }
    else
    {
        [self respring];
    }
}

-(void)respring
{
    pid_t pid;
    int status;
    const char* args[] = {"sbreload", NULL};
    posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}
@end
