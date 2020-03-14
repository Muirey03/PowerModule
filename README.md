# PowerModule

## About this repo:

### What is this repository?
This is the source code for my ios control center tweak - PowerModule

### What is PowerModule?
PowerModule is a tweak that adds a control center module (similar to the default Connectivity module) with utility options such as respring, reboot, uicache and safemode

### Why would I find this useful?
PowerModule is the first third-party control center module to not use the default CCUIToggleModule or CCUIAppLauncherModule but to use it's own CCUIContentModule. This is the only place (at least at the time of writing this) where developers can see an example of how one would go about creating their own customizable control center module.

## How to create your own module similar to this:

### 1. Setting up the template:
To begin creating your own control center module, first you need to clone [the silo template](https://github.com/ioscreatix/SiloToggleModule), then add in any extra headers from [ControlCenterUIKit](http://developer.limneos.net/?ios=11.1.2&framework=ControlCenterUIKit.framework) you might need (you can probably just copy the ones found in the headers folder in this repository unless you are making something much more elaborate such as a slider).

### 2. Creating the base:
Now we can begin making the actual module. Firstly we need to make two classes (replacing the CTXTestModule class found in the silo template), one inheriting from `NSObject <CCUIContentModule>` and one inheriting from `UIViewController <CCUIContentModuleContentViewController>`. In the init for the CCUIContentModule, set the `_contentViewController` to a new instance of your CCUIContentModuleContentViewController. (If you are making a background view controller as well, also set that). Now go into your Info.plist, here you can set any values you want but it is important to set the NSPrincipleClass to the class you created that inherited from `NSObject <CCUIContentModule>`. We also need to replace the lines:
```
<key>ModuleSize</key>
<dict>
	<key>columns</key>
	<string>4</string>
	<key>rows</key>
	<string>2</string>
</dict>
```
with:
```
<key>CCSModuleSize</key>
<dict>
	<key>Portrait</key>
	<dict>
		<key>Height</key>
		<integer>2</integer>
		<key>Width</key>
		<integer>2</integer>
	</dict>
	<key>Landscape</key>
	<dict>
		<key>Height</key>
		<integer>2</integer>
		<key>Width</key>
		<integer>2</integer>
	</dict>
</dict>
```
(or whatever size you want your module to be). If you want the size to be determined at runtime (eg. by using preferences), instead set the key:
```
<key>CCSGetModuleSizeAtRuntime</key>
<true/>
```

### 3. Adding elements to your module:
The base of the module is automatically created by apple's ControlCenterUIKit so we don't need to worry about creating that. You can initialise your subviews in your contentViewController's `initWithNibName:bundle:` and add them as a child view controller and as subviews (see PowerUIModuleContentViewController.m in this repository).

`viewDidAppear:` is the first method where the module is fully constructed in the heirarchy, so here is where I first call `layoutCollapsed` to layout the buttons in the collapsed state.

### 4. Laying out these elements:

You should create every element from apple's ControlCenterUIKit that you want to create by using it's own view controller. For instance, for every CCUILabeledRoundButton you want to add, you need to create a class for it inheriting from `CCUILabeledRoundButtonViewController` and create that instead of just creating the UIView from the contentViewController. For every element you create, you can get its desired size using the `[someElementVC.view sizeThatFits:size]` method in `layoutCollapsed`. Using this and the module size, you can correctly layout the buttons in a grid (or however you want them arranged). I perform the layout using constraints as it makes animating the transition to the expanded state easier.

To perform the animations to the expanded state, and back to the collapsed state afterward, you must implement the `viewWillTransitionToSize:withTransitionCoordinator:` method. Here you can use the `animateAlongsideTransition:` method on the coordinator to perform the animation. I recommend looking at my implementation of all this in PowerUIModuleContentViewController.m to get a more detailed idea of how this is achieved.

### 5. Attaching actions to your buttons:
**This step only applies to CCUILabeledRoundButtons**

Just override the `buttonTapped` method on the CCUILabeledRoundButtonViewController and call what you want to from there. If you want to use it as a toggle, call `[super buttonTapped:arg1];` before adding your code to the `buttonTapped` method (arg1 is equal to whether the button is enabled or disabled).

## Wow, that's awesome! Where can I find you on social media?
My reddit account is [u/Muirey03](https://www.reddit.com/user/muirey03) and my twitter is [@Muirey03](https://twitter.com/Muirey03). You can also find me over at the [r/jailbreak discord server](https://discord.gg/jb) @Muirey03.

### I NEED YOUR HELP!
If you need help with anything, feel free to message me on [reddit](https://www.reddit.com/user/muirey03) or ask me (and the other amazing devs in r/jailbreak) anything in the [r/jailbreak discord server](https://discord.gg/jb).

## Credits:
[Muirey03](https://twitter.com/muirey03) (that's me) - For creating the tweak

[opa334](https://twitter.com/opa334dev) - For making CCSupport and for helping me disassemble the Connectivity Module

[macs](https://twitter.com/maxbridgland) - For making the icon glyphs used in PowerModule

The Auxilium Team - For allowing me to use their repo and for helping me with some things I was stuck on

[THE_PINPAL614](https://twitter.com/TPinpal) - For [the initial concept](https://www.reddit.com/r/jailbreak/comments/8kb0v1/request_2x2_power_module_for_ios_11/?utm_content=title&utm_medium=user&utm_source=reddit&utm_name=frontpage).