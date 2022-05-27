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
        let cases = TestGenerator.testArrays(caseNum: 1000, maxValue: 1000, maxSize: 1000)
        var arr2 = [Int]()
        var testCaseNum = 0
        for var testCase in cases {
            testCaseNum += 1
            Sort.bubbleSort(arr: &testCase)
            arr2 = testCase.sorted()
            for i in 0..<testCase.count {
                XCTAssert(testCase[i] == arr2[i])
            }
            print("============= testCase \(testCaseNum) passed ==============")
        }
    }
    
//    func testQuickSort() throws {
//        var list = [1,3,4,5,12,2,4,5]
//        Sort.quickSort(list: &list)
//        print(list)
//        XCTAssert(true)
//    }
    
    func testSelectionSort() throws {
        var list = [1,3,4,5,12,2,4,5]
        Sort.selectionSort(arr: &list)
        print(list)
        XCTAssert(true)
    }
    
    func testInsertSort() throws {
        var list = [1,3,4,5,12,2,4,5]
        Sort.insertSort(arr: &list)
        print(list)
        XCTAssert(true)
    }
    
    func testMergeSort() throws {
        let cases = TestGenerator.testArrays(caseNum: 1000, maxValue: 1000, maxSize: 1000)
        var arr2 = [Int]()
        var testCaseNum = 0
        for var testCase in cases {
            testCaseNum += 1
            Sort.mergeSort(arr: &testCase)
            arr2 = testCase.sorted()
            for i in 0..<testCase.count {
                XCTAssert(testCase[i] == arr2[i])
            }
            print("============= testCase \(testCaseNum) passed ==============")
        }
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
    
    func testThreeSumClosest() throws {
        let arr = [1,1,1,0]
        Algorithm_Learn().threeSumClosest(arr, -1000)
        XCTAssert(true)
    }
    
    func testFind() throws {
        let arr = [1,1,2,2,3,3,4,4,5]
        let _ = Find.findOddTimers(arr: arr)
        XCTAssert(true)
    }
    
    func testFind2() throws {
        let arr = [1,1,2,2,3,3,4,4,5,3]
        let result = Find.findOddTimersTwo(arr: arr)
        print(result)
        XCTAssert(true)
    }
    func testFindLowArea() throws {
        let arr = [5, 4, 3, 6, 7, 9, 20]
        let result = Find.findLowArea(arr: arr)
        print(result)
        XCTAssert(true)
    }
}
