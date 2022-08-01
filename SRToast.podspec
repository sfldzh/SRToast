Pod::Spec.new do |spec|
  spec.name         = "SRToast"
  spec.version      = "0.0.7"
  spec.summary      = "加载和提示模块"
  spec.swift_version      = "5.0"
  spec.description  = <<-DESC
                        一个加载和提示模块
                   DESC
  spec.homepage     = "https://www.baidu.com/"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  # spec.license      = "MIT (example)"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "施峰磊" => "shifenglei1216@163.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "12.0"
  spec.ios.deployment_target = "12.0"
  spec.source       = { :git => "https://github.com/sfldzh/SRToast.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
  spec.resource     = 'Classes/SRToast.bundle'
end
