

Pod::Spec.new do |s|

s.name         = "JPPhotoBrowser"
s.version      = "1.0.2"
s.summary      = "Browse picture like WeChat."
s.homepage     = "https://github.com/baiyidjp/JPPhotoBrowserDemo"
s.license      = "MIT"
s.author             =  "baiyi"
s.ios.deployment_target = "8.0"
s.source       = { :git => "https://github.com/baiyidjp/JPPhotoBrowserDemo.git", :tag => "#{s.version}" }
s.source_files  = "JPPhotoBrowser/*.{h,m}"
s.requires_arc = true
s.dependency "SDWebImage"
# pod trunk push --allow-warnings

end
