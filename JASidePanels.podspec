Pod::Spec.new do |s|
  s.name        = 'JASidePanels'
  s.version     = ‘1.0.0’
  s.authors     = { 'Jesse Andersen' => 'https://github.com/gotosleep' }
  s.homepage    = 'https://github.com/gotosleep/JASidePanels'
  s.summary     = 'JASidePanels is a UIViewController container designed for presenting a center panel with revealable side panels - one to the left and one to the right. The main inspiration for this project is the menuing system in Path 2.0 and Facebook's iOS apps.'
  s.source      = { :git => 'https://github.com/adrianosouzapd/JASidePanels.git',
                    :tag => s.version.to_s }
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.platform = :ios, '5.0'
  s.requires_arc = true
  s.source_files = 'JASidePanels/Source'
  s.public_header_files = 'JASidePanels/Source/*.h'

  s.ios.deployment_target = '5.0'
  s.ios.frameworks = 'QuartzCore'
end
