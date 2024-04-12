Pod::Spec.new do |s|
  s.name = "ModalTransitioning"
  s.version = "5.2.0"
  s.license = "MIT"
  s.summary = "Like the default modal present transitioning with custom animation."
  s.homepage = "https://github.com/cuzv/ModalTransitioning"
  s.author = { "Shaw" => "cuzval@gmail.com" }
  
  s.ios.deployment_target = "12.0"

  s.source = { :git => "https://github.com/cuzv/ModalTransitioning.git", :tag => s.version }
  s.source_files = "Sources/*.swift"
  s.requires_arc = true
  s.swift_versions = '5'

  s.resource_bundles = {
    'ModalTransitioning' => ['Resources/PrivacyInfo.xcprivacy']
  }
end
