#import "RebootButtonController.h"
#import <ControlCenterUIKit/CCUILabeledRoundButton.h>
#import <ControlCenterUIKit/CCUIRoundButton.h>
#import <spawn.h>
#import <objc/runtime.h>

#define prefsDict [[NSUserDefaults alloc] initWithSuiteName:@"com.muirey03.powermoduleprefs"]

@interface FBSystemService : NSObject
+(id)sharedInstance;                        //existing presence of object
-(void)shutdownAndReboot:(BOOL)arg1;    //shutting down with the option to reboot (the boolean value)
-(void)exitAndRelaunch:(BOOL)arg1;        //restart the FrontBoard process (thus restarting SpringBoard as well; the boolean value has no change, the process restarts anyway)
-(void)nonExistantMethod;                    //fake method to crash in a safe way, loading SafeMode
@end

@implementation RebootButtonController

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
        //this is the longer distance (from the left of the module to the left of the top-right button)
        CGFloat rightF = [self mWidth] - leftF - bWidth;

        //each button is positioned differently - this one is the bottom-right - we also need to set the width here
        self.view.frame = CGRectMake(rightF, rightF, bWidth, bWidth);
    }

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

//this is what is called when the button is pressed, if you want to use it as a toggle, call [super buttonTapped:arg1]; - arg1 is where the button is selected or not
-(void)buttonTapped:(id)arg1
{
    if ([[prefsDict valueForKey:@"RebootConf"] boolValue])
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
    //[[objc_getClass("FBSystemService") sharedInstance] shutdownAndReboot:YES];
    pid_t pid;
    int status;
    const char* args[] = {"ldRun", NULL, NULL, NULL};
    posix_spawn(&pid, "/usr/bin/ldRun", NULL, NULL, (char* const*)args, NULL);
    waitpid(pid, &status, WEXITED);
}
@end
