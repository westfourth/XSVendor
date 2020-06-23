#

Pod::Spec.new do |spec|

  spec.name         = "XSVendor"
  spec.version      = "7.0.0"
  spec.summary      = "XSVendor"

  spec.description  = <<-DESC
  						小工具
                   DESC

  spec.homepage     = "https://github.com/westfourth/XSVendor"
  spec.license      = "MIT"
  spec.author             = { "westfourth" => "xisixisi@gmail.com" }

  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/westfourth/XSVendor.git" }

  spec.source_files  = "*.{h,m}"

end