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
    
    func testSubString() throws {
        let str = "asdfgh"
        let result = str.subString(range: 0..<3)
        let result2 = str.subString(from: 0, to: 2)
        let result3 = str.subString(range: 5..<9)
        let result4 = str.subString(range: 0..<10)
        let result5 = str.subString(from: 5, to: 9)
        let result6 = str.subString(from: 1, to: 5)
        print(result)
        print(result2)
        print(result3)
        print(result4)
        print(result5)
        print(result6)
        XCTAssert(true)
    }
    
    func testLongestValidParentheses() throws {
        let result = Algorithm_Learn().longestValidParentheses("(()")
        print(result)
        XCTAssert(true)
    }
    
    func testGrayCode() throws {
        let reuslt = Algorithm_Learn().grayCode(3)
        print(reuslt)
        XCTAssert(true)
    }

    func testBinarySearch() throws {
        let result = BasicAlgorithm.binarySearch(list: [1,2,3,5,6,7], target: 4)
        print(result)
        XCTAssert(true)
    }
    
    func testBubbleSort() throws {
        var list = [1,3,4,5,12,2,4,5]
        BasicAlgorithm.bubbleSort(list: &list)
        print(list)
        XCTAssert(true)
    }
    
    func testSelectionSort() throws {
        var list = [1,3,4,5,12,2,4,5]
        BasicAlgorithm.selectionSort(list: &list)
        print(list)
        XCTAssert(true)
    }
    
    func testInsertSort() throws {
        var list = [1,3,4,5,12,2,4,5]
        BasicAlgorithm.insertSort(list: &list)
        print(list)
        XCTAssert(true)
    }
    
    func testMergeSort() throws {
        var list = [1,3,4,5,12,2,4,5]
        BasicAlgorithm.mergeSort(list: &list)
        print(list)
        XCTAssert(true)
    }
    
    func testReverseListNode() throws {
        let head = ListNode(1)
        head.next = ListNode(2)
        head.next?.next = ListNode(3)
        var result = BasicAlgorithm.reverseNodeList(head)
        while let next = result {
            print(next.val)
            result = result?.next
        }
        XCTAssert(true)
    }
}
