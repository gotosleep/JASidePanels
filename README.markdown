JASidePanels
===

JASidePanels is a UIViewController container designed for presenting a center panel with revealable side panels - one to the left and one to the right.  The main inspiration for this project is the menuing system in Path 2.0 and Facebook's iOS apps.

Demo
---
![iPhone Example](https://img.skitch.com/20120322-dx6k69577ra37wwgqgmsgksqpx.jpg)
![iPad Example](https://img.skitch.com/20120322-ttu951nfb8cpd5ti5r1ni8428y.jpg)

Example 1: Code
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

Example 2: Storyboards
---

1. Create a subclass of `JASidePanelController`. In this example we call it `MySidePanelController`.
2. In the Storyboard designate the root view's owner as `MySidePanelController`.
3. Make sure to `#import "JASidePanelController.h"` in `MySidePanelController.h`.
4. Add more view controllers to your Storyboard, and give them identifiers "leftViewController", "centerViewController" and "rightViewController". Note that in the new XCode the identifier is called "Storyboard ID" and can be found in the Identity inspector (in older versions the identifier is found in the Attributes inspector).
5. Add a method `awakeFromNib` to `MySidePanelController.m` with the following code:

```  objc

-(void) awakeFromNib
{
  [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
  [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];
  [self setRightPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"rightViewController"]];
}

```

Usage
---

Only two files are required for using JASidePanels: ` JASidePanelController.h ` & ` JASidePanelController.m `

The easiest way to use JASidePanels is to copy the files into your XCode Project.

Alternatively, you can setup a git submodule and reference the files in your Xcode project. I prefer this method as it enables you to receive bugfixes/updates for the project.
` git submodule add https://github.com/gotosleep/JASidePanels.git JASidePanels `

Make sure to include the QuartzCore framework in your target.

UIViewController+JASidePanel Category
---

A UIViewController+JASidePanel category is included in the project. Usage is optional. The category adds a single convenience property to UIViewController: __sidePanelController__. The property provides access to the nearest JASidePanelController ancestor in your view controller heirarchy. It behaves similar to the _navigationController_ UIViewController property provided by Apple. Here's an example:

``` objc

#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"

@interface JALeftViewController : UIViewController
@end

@implementation JALeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // sweet, I can access my parent JASidePanelController as a property!
    [self.sidePanelController showCenterPanelAnimated:YES];
}

@end

```

Requirements
---

JASidePanels requires iOS 5.0+ and Xcode 4.3+ The projects uses ARC, but it may be used with non-ARC projects by setting the: ` -fobjc-arc ` compiler flag on ` JASidePanelController.m `. You can set this flag under Target -> Build Phases -> Compile Sources

Apps
---
JASidePanels is used in the following apps:

* Scribd - [http://itunes.apple.com/us/app/scribd-worlds-largest-online/id542557212?ls=1&mt=8](http://itunes.apple.com/us/app/scribd-worlds-largest-online/id542557212?ls=1&mt=8)
* Float Reader - [http://itunes.apple.com/us/app/float-reader/id447992005?ls=1&mt=8](http://itunes.apple.com/us/app/float-reader/id447992005?ls=1&mt=8)

License
---

```

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 ```

Alternatives
---
Other projects implementing a similar UI

* DDMenuController - [https://github.com/devindoty/DDMenuController](https://github.com/devindoty/DDMenuController)
* JTRevealSidebarDemo - [https://github.com/mystcolor/JTRevealSidebarDemo](https://github.com/mystcolor/JTRevealSidebarDemo)
* ECSlidingViewController - [https://github.com/edgecase/ECSlidingViewController](https://github.com/edgecase/ECSlidingViewController)
* ViewDeck - [https://github.com/Inferis/ViewDeck](https://github.com/Inferis/ViewDeck)
* ZUUIRevealController - [https://github.com/pkluz/ZUUIRevealController](https://github.com/pkluz/ZUUIRevealController)
* GHSidebarNav - [https://github.com/gresrun/GHSidebarNav](https://github.com/gresrun/GHSidebarNav)
