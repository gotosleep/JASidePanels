Pod::Spec.new do |s|
  s.name         = "JASidePanels"
  s.version      = "1.3.2"
  s.summary      = "Reveal side ViewControllers similar to Facebook/Path's menu"
  s.description  = <<-DESC
UIViewController container designed for presenting a center panel with revealable side panels - one to the left and one to the right.",
                   DESC
  s.homepage     = "https://github.com/evfemist/JASidePanels"
  s.license      = { :type => "MIT", :file => "README.markdown" }
  s.authors            = { "Jesse Andersen" => "gotosleep@gmail.com",
						   "Roman Stetsenko" => "evfemist@gmail.com"}
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/evfemist/JASidePanels.git", :tag => "#{s.version}" }
  s.source_files  = "JASidePanels/Source/*"
  s.frameworks = "QuartzCore"
  s.requires_arc = true
end
