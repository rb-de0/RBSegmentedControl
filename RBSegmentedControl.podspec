Pod::Spec.new do |s|
  s.name             = "RBSegmentedControl"
  s.version          = "0.1.1"
  s.summary          = "A Color Customizable UISegmentedControl"

  s.description      = <<-DESC
RBSegmentedControl is SubClass of UIView that you can customize the color .
                       DESC

  s.homepage         = "https://github.com/rb-de0/RBSegmentedControl"
  s.license          = 'MIT'
  s.author           = { "rb_de0" => "rebirth.de0@gmail.com" }
  s.source           = { :git => "https://github.com/rb-de0/RBSegmentedControl.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rb_de0'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'RBSegmentedControl' => ['Pod/Assets/*.png']
  }
  s.frameworks   = 'UIKit'
end
