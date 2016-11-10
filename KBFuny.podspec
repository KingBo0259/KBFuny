
Pod::Spec.new do |s|


  s.name         = "KBFuny"
  s.version      = "0.0.1"
  s.summary      = "A short description of KBFuny."

  s.description  = <<-DESC
  		       自定义仓库
                      * Markdown 格式
                   DESC

  s.homepage     = "https://github.com/KingBo0259/KBFuny"
  
  s.author             = { "jinlb" => "jlb@kuaihuoyun.com" }

  

  s.source       = { :git => "https://github.com/KingBo0259/KBFuny.git"}

  s.source_files  = "KBFuny/**/*.{h,m}"


  s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'    #所需的framework,多个用逗号隔开



end
