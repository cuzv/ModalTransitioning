load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "ModalTransitioning",
    srcs = glob([
        "Sources/**/*.swift",
    ]),
    data = [
        ":ModalTransitioningResources",
    ],
    module_name = "ModalTransitioning",
    visibility = [
        "//visibility:public",
    ],
    deps = [
    ],
)

apple_resource_bundle(
    name = "ModalTransitioningResources",
    bundle_name = "ModalTransitioning",
    resources = glob([
        "Resources/*",
    ]),
)
