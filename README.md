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
(or whatever size you want your module to be)

### 3. Adding elements to your module:
The base of the module is automatically created by apple's ControlCenterUIKit so we don't need to worry about creating that. If you are using elements from apple's default ControlCenterUIKit, you need to initialize them in your ContentViewController's `initWithNibName` and add them as a child view controller (see PowerUIModuleContentViewController.m in this repository), if you are not using elements from apple's default ControlCenterUIKit, feel free to initialize them in `loadView`.

The size of the module is not set until `viewDidLayoutSubviews` so that is where we will be adding our elements as subviews and passing the module width onto them (the module width can be found by calling `elf.view.bounds.size.width` on the ContentViewController)

### 4. Laying out these elements:
**If you are not using elements from apple's ControlCenterUIKit, skip this step, you can set the frames of your elements wherever you want (I recommend in `viewDidLayoutSubviews` if you want to use the module width, which you probably do).**

You should create every element from apple's ControlCenterUIKit that you want to create by using it's own view controller. For instance, for every CCUILabeledRoundButton you want to add, you need to create a class for it inheriting from `CCUILabeledRoundButtonViewController` and create that instead of just creating the UIView from the ContentViewController (trust me, you'll thank me in the long run). The subviews of the view controlled by each controller will be set automatically by apple's ControlCenterUIKit based on the screen size of the device, the size of the actual view controlled by the ViewController however, has to be set manually. This is done in the ViewController's `viewDidLayoutSubviews` method, here you can get the desired size by getting the subview of the view (yes, really!). For instance if you wanted to set the width of a CCUILabelledRoundButton, you would set it to `[[self buttonContainer] buttonView].frame.size.width`. The `viewDidLayoutSubviews` method is also where you can do any maths using the element and module size to work out the frame of the element (see RebootButtonController.m if you want to see how to layout four buttons in an equal grid).

### 5. Attaching actions to your buttons:
**This step only applies to CCUILabeledRoundButtons**

Just override the `buttonTapped` method on the CCUILabeledRoundButtonViewController and call what you want to from there. If you want to use it as a toggle, call `[super buttonTapped:arg1];` before adding your code to the `buttonTapped` method (arg1 is equal to whether the button is enabled or disabled).

## Wow, that's awesome! Where can I find you on social media?
My reddit account is [u/Muirey03](https://www.reddit.com/user/muirey03) and my twitter is [@Muirey03](https://twitter.com/Muirey03). You can also find me over at the [Auxilium discord server](https://discord.gg/E9T5gDF).

### I NEED YOUR HELP!
If you need help with anything, feel free to message me on [reddit](https://www.reddit.com/user/muirey03) or ask me (and the other amazing devs in Auxilium) anything in the [Auxilium discord server](https://discord.gg/E9T5gDF).

## Credits:
[Muirey03](https://www.reddit.com/user/muirey03) (that's me) - For creating the tweak
[opa334](https://www.reddit.com/user/opa334/) - For making CCSupport and for helping me disassemble the Connectivity Module
[macs](https://www.reddit.com/user/thecoderkiller) - For making the icon glyphs used in PowerModule
[The Auxilium Team](https://discord.gg/E9T5gDF) - For allowing me to use their repo and for helping me with some things I was stuck on
[THE_PINPAL614](https://www.reddit.com/user/THE_PINPAL614) - For [the initial concept](https://www.reddit.com/r/jailbreak/comments/8kb0v1/request_2x2_power_module_for_ios_11/?utm_content=title&utm_medium=user&utm_source=reddit&utm_name=frontpage).