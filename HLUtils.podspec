Pod::Spec.new do |spec|

  spec.name         = "HLUtils"
  spec.version      = "1.0.1"
  spec.summary      = "HLUtils是iOS工具类"

  # 描述
  spec.description  = <<-DESC
      HLUtils是iOS工具类，通过类方法使用非常方便。
  DESC

  # 项目主页
  spec.homepage     = "https://github.com/huangchangweng/HLUtils"
 
  # 开源协议
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  
  # 作者
  spec.author             = { "黄常翁" => "599139419@qq.com" }
  
  # 支持平台
  spec.platform     = :ios, "9.0"

  # git仓库，tag
  spec.source       = { :git => "https://github.com/huangchangweng/HLUtils.git", :tag => spec.version.to_s }

  # 资源路径
  spec.source_files  = "HLUtils/HLUtils/*.{h,m}"

  # 依赖系统库
  spec.frameworks = "UIKit"

end
