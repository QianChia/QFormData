Pod::Spec.new do |s|
  s.name         = 'QFormData'
  s.version      = '1.0.1'
  s.ios.deployment_target = '7.0'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/QianChia/QFormData'
  s.authors      = {'QianChia' => 'jhqian0228@icloud.com'}
  s.summary      = 'A simple encapsulation of upload file data'
  s.source       = {:git => 'https://github.com/QianChia/QFormData.git', :tag => s.version}
  s.source_files = 'QFormData'
  s.requires_arc = true
end
