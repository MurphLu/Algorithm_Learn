import XCTest
@testable import Algorithm_Learn

final class Algorithm_LearnTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Algorithm_Learn().text, "Hello, World!")
    }
    
    func testTwoSum() throws {
        let result = Algorithm_Learn().twoSum([1,2,3,4], 6)
        XCTAssert(!result.isEmpty)
    }
    
    func testAddTwoNumbers() throws {
        let node = ListNode(1)
        let node2 = ListNode(9)
        let result = Algorithm_Learn().addTwoNumbers(node, node2)
        XCTAssert(result!.val == 0 && result!.next!.val == 1)
    }
}
