#
# Be sure to run `pod lib lint KJCurveSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KJCurveSlider'
  s.version          = '0.1.0'
  s.summary          = 'Curve slider - to slide from 0 to 100 in curve shape'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
It's curve slider, It provides curved shape to slide around from 0 to 100 percent, You can use it when you required a curved shape on clider rather than traditional iOS line shape slider.
                       DESC

  s.homepage         = 'https://github.com/KiranJasvanee/KJCurveSlider'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kiran Jasvanee' => 'kiran.jasvanee@yahoo.com' }
  s.source           = { :git => 'https://github.com/KiranJasvanee/KJCurveSlider.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/KiranJasvanee'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KJCurveSlider/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KJCurveSlider' => ['KJCurveSlider/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
