#
# Be sure to run `pod lib lint KJCircularSlider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KJCircularSlider'
  s.version          = '0.1.0'
  s.summary          = 'Circular slider - to slide from 0 to 100 in circular shape'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
It's circular slider, It provides circular shape to slide around from 0 to 100 percent, You can use it when you required a circular shape on slider rather than traditional iOS line shape slider.
                       DESC

  s.homepage         = 'https://github.com/KiranJasvanee/KJCircularSlider'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kiran Jasvanee' => 'kiran.jasvanee@yahoo.com' }
  s.source           = { :git => 'https://github.com/KiranJasvanee/KJCircularSlider.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/KiranJasvanee'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KJCircularSlider/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KJCircularSlider' => ['KJCircularSlider/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
