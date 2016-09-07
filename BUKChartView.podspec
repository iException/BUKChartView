Pod::Spec.new do |s|
  s.name             = 'BUKChartView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BUKChartView.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/iException/BUKChartView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'monzy613' => 'monzy613@gmail.com' }
  s.source           = { :git => 'https://github.com/iException/BUKChartView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'BUKChartView/Classes/**/*'
  s.frameworks = 'UIKit', 'QuartzCore'
end
