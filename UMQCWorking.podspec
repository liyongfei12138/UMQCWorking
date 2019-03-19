#
# Be sure to run `pod lib lint UMQCWorking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UMQCWorking'
  s.version          = '0.2.0'
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

  s.ios.deployment_target = '8.0'

  s.source_files = 'UMQCWorking/Classes/**/*'
s.resources =  'UMQCWorking/QCKJBundle.bundle'


 s.dependency 'AFNetworking'
 s.dependency 'WebViewJavascriptBridge'
 s.dependency 'JPush'
 s.dependency 'UMengAnalytics-NO-IDFA'
end
