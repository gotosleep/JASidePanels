JASidePanels
===

JASidePanels is a UIViewController container designed for presenting a center panel with revealable side panels - one to the left and one to the right.  The main inspiration for this project is the menuing system in Path 2.0 and Facebook's iOS apps.

Demo
---
![iPhone Example](https://img.skitch.com/20120322-dx6k69577ra37wwgqgmsgksqpx.jpg)
![iPad Example](https://img.skitch.com/20120322-ttu951nfb8cpd5ti5r1ni8428y.jpg)

Example Code
---

```  objc

#import "JAAppDelegate.h"

#import "JASidePanelController.h"
#import "JACenterViewController.h"
#import "JALeftViewController.h"
#import "JARightViewController.h"

@implementation JAAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.viewController = [[JASidePanelController alloc] init];
	self.viewController.leftPanel = [[JALeftViewController alloc] init];
	self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[JACenterViewController alloc] init]];
	self.viewController.rightPanel = [[JARightViewController alloc] init];
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end

```

Usage
---

Only two files are required for using JASidePanels: ` JASidePanelController.h ` & ` JASidePanelController.m `

The easiest way to use JASidePanels is to copy the files into your XCode Project.

Alternatively, you can setup a git submodule and reference the files in your Xcode project. I prefer this method as it enables you to receive bugfixes/updates for the project.
` git submodule add https://github.com/gotosleep/JASidePanels.git JASidePanels `

Requirements
---

JASidePanels requires iOS 5.0+ The projects uses ARC, but it may be used with non-ARC projects by setting the: ` -fobjc-arc ` compiler flag on ` JASidePanelController.m `. You can set this flag under Target -> Build Phases -> Compile Sources

Apps
---
JASidePanels is used in the following apps:

* Float Reader - [http://itunes.apple.com/us/app/float-reader/id447992005?ls=1&mt=8](http://itunes.apple.com/us/app/float-reader/id447992005?ls=1&mt=8 "Float Reader")

Alternatives
---
Other projects implementing a similar UI

* DDMenuController - [https://github.com/devindoty/DDMenuController](https://github.com/devindoty/DDMenuController)
* JTRevealSidebarDemo - [https://github.com/mystcolor/JTRevealSidebarDemo](https://github.com/mystcolor/JTRevealSidebarDemo)
* ECSlidingViewController - [https://github.com/edgecase/ECSlidingViewController](https://github.com/edgecase/ECSlidingViewController)
* ViewDeck - [https://github.com/Inferis/ViewDeck](https://github.com/Inferis/ViewDeck)
* ZUUIRevealController - [https://github.com/pkluz/ZUUIRevealController](https://github.com/pkluz/ZUUIRevealController)
