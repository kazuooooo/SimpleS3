#
# Be sure to run `pod lib lint SimpleS3.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleS3'
  s.version          = '0.1.0'
  s.summary          = 'Thin wrapper for handling S3 in swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Thin wrapper for handling S3 in swift
  DESC

  s.homepage         = 'https://github.com/kazuooooo/SimpleS3'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kazuooooo' => 'matsumotokazuya7@gmail.com' }
  s.source           = { :git => 'https://github.com/kazuooooo/SimpleS3.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SimpleS3/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SimpleS3' => ['SimpleS3/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AWSS3', '~> 2.13.0'
  s.dependency 'AWSCognito', '~> 2.13.0'
end
