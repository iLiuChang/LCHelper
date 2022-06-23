
Pod::Spec.new do |s|
  s.name         = "LCHelper"
  s.version      = "2.5.0"
  s.summary      = "Some categories in Objective-C."
  s.homepage     = "https://github.com/iLiuChang/LCHelper"
  s.license      = "MIT"
  s.author       = "LiuChang"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/iLiuChang/LCHelper.git", :tag => s.version }
  s.requires_arc = true
  s.source_files = "LCHelper/LCHelper.h"
  s.subspec "Foundation" do |ss|
    ss.source_files = "LCHelper/Foundation/*.{h,m}"
  end
  s.subspec "UIKit" do |ss|
    ss.source_files = "LCHelper/UIKit/*.{h,m}"
  end
end
