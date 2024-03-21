Pod::Spec.new do |s|
  s.name      = "FlyingViewsAnimation"
  s.version   = "1.0.0"
  s.swift_version = "5.5"
  s.summary   = "Customizable animated view."
  s.description  = "FlyingViewsAnimation is a customizable view that will allow you to decorate your iOS application with animation with a continuous stream of flying views distributed randomly throughout the background."
  s.homepage  = "https://github.com/idapgroup/FlyingViewsAnimation.git"
  s.license   = { :type => "New BSD", :file => "LICENSE" }
  s.author    = { "IDAP Group" => "hello@idapgroup.com" }
  s.source    = { :git => "https://github.com/idapgroup/FlyingViewsAnimation.git",
                  :tag => s.version.to_s }

  # Platform setup
  s.requires_arc          = true
  s.ios.deployment_target = '15.0'

  # Preserve the layout of headers in the Module directory
  s.header_mappings_dir   = 'Source'
  s.source_files          = 'Source/**/*.{swift,h,m,c,cpp}'
end
