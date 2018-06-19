#import "RespringButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.muirey03.powermoduleprefs.plist"
#define prefsDict [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH]

@implementation RespringButtonController
//here is where we set the width of the CCUILabeledRoundButton - the width of CCUIRoundButton is set automatically so we just use that to set the width of the CCUILabeledRoundButton
-(void)viewDidLayoutSubviews
{
    //this will be true if we are in the collapsed view, we don't want to position the buttons here if we are in the expanded view - that will be done in willTransitionToExpandedContentMode
    if (![self isExpanded] || self.view.window.bounds.size.width == 0)
    {
        //get the width of the CCUIRoundButton
        CGFloat bWidth = [[self buttonContainer] buttonView].frame.size.width;
        //this is the smaller distance (from the left of the module to the left of the top-left button)
        CGFloat leftF = ([self mWidth] - (2 * bWidth)) / 3;

        //each button is positioned differently - this one is the top-left - we also need to set the width here
        self.view.frame = CGRectMake(leftF, leftF, bWidth, bWidth);
    }
}

//this is what is called when the button is pressed, if you want to use it as a toggle, call [super buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict valueForKey:@"RespringConf"] boolValue])
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
    const char* args[] = {"killall", "-9", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}
@end
