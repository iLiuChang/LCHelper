
Pod::Spec.new do |s|

  s.name         = "LCHelper"
  s.version      = "1.2.0"
  s.summary      = "项目中用的一些工具类和Extension"
  s.homepage     = "https://github.com/iLiuChang/LCHelper"

  s.license      = "MIT"

  s.author            = "LiuChang"
 
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/iLiuChang/LCHelper.git", :tag => s.version }

  s.requires_arc = true
  s.source_files  = "LCHelper/**/*.{h,m}"
#  s.public_header_files = 'LCHelper/*.h' 

  s.framework  = "UIKit"

  s.requires_arc = true

  s.subspec 'Extension' do |ss|
    ss.source_files = 'LCHelper/Extension/**/*'
  
 #   ss.public_header_files = 'LCHelper/Extension/*.h'
  end

  s.subspec 'Util' do |ss|
    ss.source_files = 'LCHelper/Util/*'
    
#    ss.public_header_files = 'LCHelper/Util/*.h'
  end

end
