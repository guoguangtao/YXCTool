Pod::Spec.new do |spec|

  spec.name         = "YXCTools"
  spec.version      = "1.0.0"
  spec.summary      = "Some tools and methods used in daily development."
  spec.description  = <<-DESC
                   DESC
  spec.homepage     = "https://github.com/guoguangtao/YXCTool"
  spec.license      = "MIT"
  spec.author             = { "guoguangtao" => "Jude_guo@163.com" }
  spec.source       = { :git => "https://github.com/guoguangtao/YXCTool", :tag => "v#{spec.version}" }
  spec.source_files  = "YXCTools/YXCTools/**/*.{h,m}"
  spec.platform     = :ios, "8.0"
  spec.requires_arc = true

end