import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  [
    testCase(ModalTransitioningTests.allTests),
  ]
}
#endif
