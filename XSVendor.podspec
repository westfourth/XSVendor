#

Pod::Spec.new do |spec|

  spec.name         = "XSVendor"
  spec.version      = "2.0.0"
  spec.summary      = "XSVendor"

  spec.description  = <<-DESC
  						常用小方法集合，每个类都是独立的。
                   DESC

  spec.homepage     = "https://github.com/westfourth/XSVendor"
  spec.license      = "MIT"
  spec.author             = { "westfourth" => "xisixisi@gmail.com" }

  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/westfourth/XSVendor.git" }

  spec.source_files  = "*.{h,m}"

end
