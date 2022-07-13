import XCTest
@testable import SwiftMail

final class SwiftMailTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftMail().text, "Hello, World!")
    }
}
