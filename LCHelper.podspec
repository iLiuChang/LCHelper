
Pod::Spec.new do |s|
  s.name         = "LCHelper"
  s.version      = "2.3.0"
  s.summary      = "Extensions to UIKit and Foundation."
  s.homepage     = "https://github.com/iLiuChang/LCHelper"
  s.license      = "MIT"
  s.author       = "LiuChang"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/iLiuChang/LCHelper.git", :tag => s.version }
  s.requires_arc = true
  s.source_files = "LCHelper/**/*.{h,m}"
#  s.public_header_files = 'LCHelper/*.h' 
  s.framework    = "UIKit"
  s.requires_arc = true
end
