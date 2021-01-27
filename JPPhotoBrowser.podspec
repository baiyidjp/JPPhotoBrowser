

Pod::Spec.new do |s|

s.name         = "JPPhotoBrowser"
s.version      = "1.0.3"
s.summary      = "Browse picture like WeChat."
s.homepage     = "https://github.com/baiyidjp/JPPhotoBrowserDemo"
s.license      = "MIT"
s.author             =  "baiyi"
s.ios.deployment_target = "9.0"
s.source       = { :git => "https://github.com/baiyidjp/JPPhotoBrowserDemo.git", :tag => "#{s.version}" }
s.source_files  = "JPPhotoBrowser/*.{h,m}"
s.requires_arc = true
s.dependency "SDWebImage"
s.dependency 'JPCategory-OC/UIView'
s.dependency 'JPUtils-OC/Layout'
# pod trunk push --allow-warnings

end
