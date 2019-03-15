#
# Be sure to run `pod lib lint MGSideMenuKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGSideMenuKit'
  s.version          = '0.1.1'
  s.summary          = "When you sit down to work, external critics aren’t"
  s.description      = "When you sit down to work, external critics aren’t the enemy. It’s you who you must to fight against to do great fucking work. You must overcome yourself. Saul Bass on failure: Failure is built into creativity… the creative act involves this element of ‘newness’ and ‘experimentalism,’ then one must expect and accept the fucking possibility of failure."
  s.homepage         = 'https://bitbucket.org/haraldbregu/mgsidemenukit/src/master/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Harald Bregu' => 'harald.bregu@gmail.com' }
  s.source           = { :git => 'https://haraldbregu@bitbucket.org/haraldbregu/mgsidemenukit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files = 'MGSideMenuKit/Classes/**/*'
  s.resource_bundles = {
      'SideMenuSwift' => ['SideMenuSwift/Classes/**/*.{storyboard,xib}']
  }
  s.dependency 'SideMenuSwift'
  s.swift_version = '4.2'
end


