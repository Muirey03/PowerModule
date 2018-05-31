#import "UICacheButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <sys/wait.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.muirey03.powermoduleprefs.plist"
#define prefsDict [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH]

@implementation UICacheButtonController
//here is where we set the width of the CCUILabeledRoundButton - the width of CCUIRoundButton is set automatically so we just use that to set the width of the CCUILabeledRoundButton
-(void)viewDidLayoutSubviews
{
    //get the width of the CCUIRoundButton
    CGFloat bWidth = [[self buttonContainer] buttonView].frame.size.width;
    //this is the smaller distance (from the left of the module to the left of the top-left button)
    CGFloat leftF = ([self mWidth] - (2 * bWidth)) / 3;
    //this is the longer distance (from the left of the module to the left of the top-right button)
    CGFloat rightF = [self mWidth] - leftF - bWidth;

    //each button is positioned differently - this one is the top-right - we also need to set the width here
    self.view.frame = CGRectMake(rightF, leftF, bWidth, bWidth);
}

//this is what is called when the button is pressed, if you want to use it as a toggle, call [self buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict valueForKey:@"UICacheConf"] boolValue])
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
    const char* args[] = {"uicache", NULL, NULL, NULL};
    posix_spawn(&pid, "/usr/bin/uicache", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
	CFRunLoopRunInMode(kCFRunLoopDefaultMode, 20.0, false);
}
@end
