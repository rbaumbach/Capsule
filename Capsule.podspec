Pod::Spec.new do |spec|
  spec.name                  = 'Capsule'
  spec.version               = '0.0.1'
  spec.summary               = 'A collection of Swift iOS protocols and wrappers for native iOS libraries and frameworks.'
  spec.homepage              = 'https://github.com/rbaumbach/Capsule'
  spec.license               = { :type => 'MIT', :file => 'MIT-LICENSE.txt' }
  spec.author                = { 'Ryan Baumbach' => 'github@ryan.codes' }
  spec.source                = { :git => 'https://github.com/rbaumbach/Capsule.git', :tag => spec.version.to_s }
  spec.requires_arc          = true
  spec.platform              = :ios
  spec.ios.deployment_target = '10.0'
  spec.source_files          = 'Capsule/Source/**/*.{swift}'
  spec.swift_version         = '5.1.2'
end
