#

Pod::Spec.new do |spec|

  spec.name         = "XSVendor"
  spec.version      = "7.0.0"
  spec.summary      = "XSVendor"

  spec.description  = <<-DESC
  						小工具
                   DESC

  spec.homepage     = "http://XXX/XSVendor"
  spec.license      = "MIT"
  spec.author             = { "雅各" => "jaco574093@gmail.com" }

  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "http://XXX/XSVendor.git" }

  spec.source_files  = "*.{h,m}"

end
