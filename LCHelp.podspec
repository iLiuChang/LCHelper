
Pod::Spec.new do |s|



  s.name         = "LCHelper"
  s.version      = "0.0.1"
  s.summary      = "项目中用的一些工具类和Extension"

  s.homepage     = "https://github.com/LiuChang712/LCHelper"

  s.license      = "MIT"

  s.author             = { "LiuChang" => "helloliuchang@163.com" }
 
   s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/LiuChang712/LCHelper.git", :tag => "0.0.1" }

  s.source_files  = "LCHelper", "LCHelper/**/*.{h,m}"
 

   s.framework  = "UIKit"

  s.requires_arc = true


end
