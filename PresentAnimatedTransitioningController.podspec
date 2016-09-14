Pod::Spec.new do |s|
  s.name = "PresentAnimatedTransitioningController"
  s.version = "1.0.0"
  s.license = "MIT"
  s.summary = "Like the default present transitioning with custom animation."
  s.homepage = "https://github.com/cuzv/PresentAnimatedTransitioningController"
  s.author = { "Moch Xiao" => "cuzval@gmail.com" }
  s.source = { :git => "https://github.com/cuzv/PresentAnimatedTransitioningController.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.source_files = "Sources/*.swift"
  s.requires_arc = true
end
