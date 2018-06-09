Pod::Spec.new do |s|
  s.name = "ModalTransitionController"
  s.version = "3.1.0"
  s.license = "MIT"
  s.summary = "Like the default modal present transitioning with custom animation."
  s.homepage = "https://github.com/cuzv/ModalTransitionController"
  s.author = { "Roy Shaw" => "cuzval@gmail.com" }
  s.source = { :git => "https://github.com/cuzv/ModalTransitionController.git", :tag => s.version }

  s.ios.deployment_target = "8.0"
  s.source_files = "Sources/*.swift"
  s.requires_arc = true
end
