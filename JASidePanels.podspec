Pod::Spec.new do |s|
  s.name        = 'JASidePanels'
  s.version     = '1.3.2'
  s.authors     = { 'Jesse Andersen' => 'https://github.com/gotosleep' }
  s.homepage    = 'https://github.com/gotosleep/JASidePanels'
  s.summary     = 'Reveal side ViewControllers similar to Facebook/Paths menu '
  s.source      = { :git => "https://github.com/adrianosouzapd/JASidePanels.git", :tag => s.version.to_s }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'JASidePanels/Source'
  s.public_header_files = 'JASidePanels/Source/*.h'

  s.ios.deployment_target = '5.0'
  s.ios.frameworks = 'QuartzCore'
end
