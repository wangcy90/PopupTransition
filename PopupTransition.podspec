Pod::Spec.new do |s|
  s.name             = 'PopupTransition'
  s.version          = '1.0.0'
  s.summary          = '弹出动画.'
  s.homepage         = 'https://github.com/wangcy90/PopupTransition'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WangChongyang' => 'chongyangfly@163.com' }
  s.source           = { :git => 'https://github.com/wangcy90/PopupTransition.git', :tag => s.version.to_s }
  s.platform         = :ios, '9.0'
  s.swift_version    = '5.0'
  s.source_files     = 'PopupTransition/**/*'
end
