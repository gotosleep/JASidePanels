Pod::Spec.new do |s|
  s.name         = "JASidePanels"
  s.version      = "1.3.3"
  s.summary      = "UIViewController container designed for presenting a center panel with revealable side panels - one to the left and one to the right."
  s.homepage     = "https://github.com/gotosleep/JASidePanels"
  s.license      = { :type => "MIT", :file => "README.markdown" }
  s.authors      = { "Jesse Andersen" => "gotosleep@gmail.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/hermanolsson/JASidePanels.git", :tag => "1.3.3" }
  s.source_files = "JASidePanels/Source/*.{h,m}"
  s.framework    = "QuartzCore"
  s.requires_arc = true
end
