#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "IPQuickModal"
  s.version          = "0.1.0"
  s.summary          = "A short description of IPQuickModal."
  s.description      = <<-DESC
  Quick way to display a modal
                       DESC
  s.license          = 'MIT'
  s.author           = { "Ying Quan Tan" => "ying.quan.tan@gmail.com" }
  s.source           = { :git => "git@github.com:brightredchilli/quick-modal.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/brightredchilli'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'

  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
