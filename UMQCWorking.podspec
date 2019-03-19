#
# Be sure to run `pod lib lint UMQCWorking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UMQCWorking'
  s.version          = '1.3.2'
  s.summary          = 'just a demo'


  s.description      = <<-DESC
        jusr a demo
                       DESC

  s.homepage         = 'https://github.com/liyongfei12138/UMQCWorking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liyongfei12138' => 'lixin@uqian.com' }
  s.source           = { :git => 'https://github.com/liyongfei12138/UMQCWorking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'UMQCWorking/TestFramework.framework/Headers/*.{h}'


    s.resources =  'UMQCWorking/QCKJBundle.bundle'

s.vendored_frameworks = 'UMQCWorking/TestFramework.framework'
s.public_header_files = 'UMQCWorking/TestFramework.framework/Headers/QCKJLib.h'

end
