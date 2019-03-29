
Pod::Spec.new do |s|

  s.name         = "LCHelper"
  s.version      = "0.1.1"
  s.summary      = "项目中用的一些工具类和Extension"
  s.homepage     = "https://github.com/iLiuChang/LCHelper"

  s.license      = "MIT"

  s.author             = { "LiuChang" => "iliuchang@foxmail.com" }
 
   s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/iLiuChang/LCHelper.git", :tag => "0.1.1" }

  s.source_files  = "LCHelper/*.{h,m}", "LCHelper/Extensions/**/*.{h,m}", "LCHelper/Utils/*.{h,m}"
 

   s.framework  = "UIKit"

  s.requires_arc = true


end
