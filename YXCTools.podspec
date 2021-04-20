Pod::Spec.new do |spec|

  spec.name         = "YXCTools"
  spec.version      = "1.0.2"
  spec.summary      = "Some tools and methods"
  spec.description  = <<-DESC
                        Some tools and methods used in daily development
                        DESC
  spec.homepage     = "https://github.com/guoguangtao/YXCTool"
  spec.license      = "MIT"
  spec.author       = { "guoguangtao" => "Jude_guo@163.com" }
  spec.source       = { :git => "https://github.com/guoguangtao/YXCTool.git", :tag => "v#{spec.version}" }
  spec.source_files = "YXCTools/YXCTools/**/*.{h,m}"
  spec.platform     = :ios, "10.0"
  spec.requires_arc = true

end
