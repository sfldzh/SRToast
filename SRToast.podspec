Pod::Spec.new do |spec|
  spec.name         = "SRToast"
  spec.version      = "0.0.8"
  spec.summary      = "加载和提示模块"
  spec.swift_version      = "5.0"
  spec.homepage     = "https://www.baidu.com/"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "施峰磊" => "shifenglei1216@163.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/sfldzh/SRToast.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.resource     = 'Classes/SRToast.bundle'
  spec.requires_arc = true
end
