using System;
using System.Drawing;
using MonoTouch.ObjCRuntime;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace JASidePanels 
{
	[BaseType (typeof (UIViewController))]
	public partial interface JASidePanelController 
	{
		[Export ("leftPanel", ArgumentSemantic.Retain)]
		UIViewController LeftPanel { get; set; }

		[Export ("centerPanel", ArgumentSemantic.Retain)]
		UIViewController CenterPanel { get; set; }

		[Export ("rightPanel", ArgumentSemantic.Retain)]
		UIViewController RightPanel { get; set; }

		[Export ("showLeftPanel:")]
		void ShowLeftPanel (bool animated);

		[Export ("showRightPanel:")]
		void ShowRightPanel (bool animated);

		[Export ("showCenterPanel:")]
		void ShowCenterPanel (bool animated);

		[Export ("showLeftPanelAnimated:")]
		void ShowLeftPanelAnimated (bool animated);

		[Export ("showRightPanelAnimated:")]
		void ShowRightPanelAnimated (bool animated);

		[Export ("showCenterPanelAnimated:")]
		void ShowCenterPanelAnimated (bool animated);

		[Export ("toggleLeftPanel:")]
		void ToggleLeftPanel (NSObject sender);

		[Export ("toggleRightPanel:")]
		void ToggleRightPanel (NSObject sender);

		[Export ("setCenterPanelHidden:animated:duration:")]
		void SetCenterPanelHidden (bool centerPanelHidden, bool animated, double duration);

		[Export ("style")]
		JASidePanelStyle Style { get; set; }

		[Export ("pushesSidePanels")]
		bool PushesSidePanels { get; set; }

		[Export ("leftGapPercentage")]
		float LeftGapPercentage { get; set; }

		[Export ("leftFixedWidth")]
		float LeftFixedWidth { get; set; }

		[Export ("leftVisibleWidth")]
		float LeftVisibleWidth { get; }

		[Export ("rightGapPercentage")]
		float RightGapPercentage { get; set; }

		[Export ("rightFixedWidth")]
		float RightFixedWidth { get; set; }

		[Export ("rightVisibleWidth")]
		float RightVisibleWidth { get; }

		[Export ("styleContainer:animate:duration:")]
		void StyleContainer (UIView container, bool animate, double duration);

		[Export ("stylePanel:")]
		void StylePanel (UIView panel);

		[Export ("minimumMovePercentage")]
		float MinimumMovePercentage { get; set; }

		[Export ("maximumAnimationDuration")]
		float MaximumAnimationDuration { get; set; }

		[Export ("bounceDuration")]
		float BounceDuration { get; set; }

		[Export ("bouncePercentage")]
		float BouncePercentage { get; set; }

		[Export ("bounceOnSidePanelOpen")]
		bool BounceOnSidePanelOpen { get; set; }

		[Export ("bounceOnSidePanelClose")]
		bool BounceOnSidePanelClose { get; set; }

		[Export ("bounceOnCenterPanelChange")]
		bool BounceOnCenterPanelChange { get; set; }

		[Export ("panningLimitedToTopViewController")]
		bool PanningLimitedToTopViewController { get; set; }

		[Export ("recognizesPanGesture")]
		bool RecognizesPanGesture { get; set; }

		[Static, Export ("defaultImage")]
		UIImage DefaultImage { get; }

		[Export ("leftButtonForCenterPanel")]
		UIBarButtonItem LeftButtonForCenterPanel { get; }

		[Export ("state")]
		JASidePanelState State { get; }

		[Export ("centerPanelHidden")]
		bool CenterPanelHidden { get; set; }

		[Export ("visiblePanel", ArgumentSemantic.Assign)]
		UIViewController VisiblePanel { get; }

		[Export ("shouldDelegateAutorotateToVisiblePanel")]
		bool ShouldDelegateAutorotateToVisiblePanel { get; set; }

		[Export ("canUnloadRightPanel")]
		bool CanUnloadRightPanel { get; set; }

		[Export ("canUnloadLeftPanel")]
		bool CanUnloadLeftPanel { get; set; }

		[Export ("shouldResizeRightPanel")]
		bool ShouldResizeRightPanel { get; set; }

		[Export ("shouldResizeLeftPanel")]
		bool ShouldResizeLeftPanel { get; set; }

		[Export ("allowRightOverpan")]
		bool AllowRightOverpan { get; set; }

		[Export ("allowLeftOverpan")]
		bool AllowLeftOverpan { get; set; }

		[Export ("allowLeftSwipe")]
		bool AllowLeftSwipe { get; set; }

		[Export ("allowRightSwipe")]
		bool AllowRightSwipe { get; set; }

		[Export ("leftPanelContainer", ArgumentSemantic.Retain)]
		UIView LeftPanelContainer { get; }

		[Export ("rightPanelContainer", ArgumentSemantic.Retain)]
		UIView RightPanelContainer { get; }

		[Export ("centerPanelContainer", ArgumentSemantic.Retain)]
		UIView CenterPanelContainer { get; }
	}

	[BaseType (typeof (UIViewController))]
	[Category]
	interface UIViewControllerExtension 
	{
		[Export ("sidePanelController")]
		JASidePanelController SidePanelController ();
	}
}
