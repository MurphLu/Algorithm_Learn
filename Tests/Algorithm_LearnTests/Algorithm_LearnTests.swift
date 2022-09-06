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
    
    func testQuickSort() throws {
        let cases = TestGenerator.testArrays(caseNum: 1000, maxValue: 99, maxSize: 10000)
        var arr2 = [Int]()
        var testCaseNum = 0
        for var testCase in cases {
            testCaseNum += 1
            Sort.quickSort(arr: &testCase)
            arr2 = testCase.sorted()
            for i in 0..<testCase.count {
                XCTAssert(testCase[i] == arr2[i])
            }
            print("============= testCase \(testCaseNum) passed ==============")
        }
    }
    
    func testBucketSort() throws {
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
    
    func testHeapSort() throws {
        let cases = TestGenerator.testArrays(caseNum: 1000, maxValue: 1000, maxSize: 1000)
        var arr2 = [Int]()
        var testCaseNum = 0
        for var testCase in cases {
            testCaseNum += 1
            Sort.heapSort(arr: &testCase)
            arr2 = testCase.sorted()
            for i in 0..<testCase.count {
                XCTAssert(testCase[i] == arr2[i])
            }
            print("============= testCase \(testCaseNum) passed ==============")
        }
    }
    
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
    
    func testAddMins() throws {
        var arr = [1,3,4,2,5]
        Question.addMins(arr: arr)
        print(Question.targetAddMin)
        XCTAssert(true)
    }
    
    func testReversePair() throws {
        var arr = [1,3,4,2,5]
        Question.reversePair(arr: arr)
        print(Question.targetReversePair)
        XCTAssert(true)
    }
    
    func testTest() throws {
        Question.sort()
        XCTAssert(true)
    }
    
    func testLNode() throws {
        let node = LNode(val: 1, next: LNode(val: 2, next: LNode(val: 3, next: LNode(val: 4, next: LNode(val: 5, next: nil)))))
        node.reverse().desc()
        XCTAssert(true)
    }
    
    func testDuLNode() throws {
        let node1 = DuLNode(val: 1, next: nil, last: nil)
        let node2 = DuLNode(val: 2, next: nil, last: nil)
        let node3 = DuLNode(val: 3, next: nil, last: nil)
        node1.next = node2
        node2.last = node1
        node2.next = node3
        node3.last = node2
        node1.reverse().desc()
        XCTAssert(true)
    }
    
    func testIsPalindrome() throws {
        let node = LNode(val: 1, next: LNode(val: 2, next: LNode(val: 3, next: LNode(val: 3, next: LNode(val: 2, next: LNode(val: 1, next: nil))))))
        node.desc()
        let result = Question.isPalindromeO1(listNode: node)
        node.desc()
        XCTAssert(result == true)
    }
    
    func testCopyNodeWithRandom() throws {
        let head = LNodeWithRandom(val:1, next: nil)
        let node2 = LNodeWithRandom(val:2, next: nil)
        let node3 = LNodeWithRandom(val:3, next: nil)
        let node4 = LNodeWithRandom(val:4, next: nil)
        let node5 = LNodeWithRandom(val:5, next: nil)
        let node6 = LNodeWithRandom(val:6, next: nil)
        let node7 = LNodeWithRandom(val:7, next: nil)
        
        head.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        
        head.random = node7
        node2.random = nil
        node3.random = node6
        node4.random = node5
        node5.random = node5
        node6.random = node7
        node7.random = head
        
        let result = Question.copyNodeListO1(listNode: head)
        
        
        XCTAssert(true)
    }
    
    
    func testGetLoopNode() throws {
        let head = LNode(val:1, next: nil)
        let node2 = LNode(val:2, next: nil)
        let node3 = LNode(val:3, next: nil)
        let node4 = LNode(val:4, next: nil)
        let node5 = LNode(val:5, next: nil)
        let node6 = LNode(val:6, next: nil)
        let node7 = LNode(val:7, next: nil)
        head.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node7
        let head2 = LNode(val:11, next: nil)
        let node12 = LNode(val:12, next: nil)
        let node13 = LNode(val:13, next: nil)
        head2.next = node12
        node12.next = node13
        node13.next = node7
        let node = Question.getFirstShareNodeNoLoop(head1: head, head2: head2)
        print(node?.val)
        XCTAssert(true)
    }
    
    func test() throws {
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        let node3 = ListNode(3)
        let node4 = ListNode(3)
        let node5 = ListNode(5)
        node1.next = node2
//        node2.next = node3
//        node3.next = node4
//        node4.next = node5
        let result = Algorithm_Learn().reverseBetween(node1, 1, 2)
        XCTAssert(true)
    }
    
    func testTree() throws{
        let tree = TreeNode(val: 5)
        let left = TreeNode(val: 1)
        let right = TreeNode(val: 4)
        let left01 = TreeNode(val: 4)
        let right01 = TreeNode(val: 5)
        
        let left02 = TreeNode(val: 3)
        let right02 = TreeNode(val: 6)
        tree.left = left
        tree.right = right
//        left.left = left01
//        left.right = right01
        right.left = left02
        right.right = right02
        print("先序遍历--递归")
        TreeBasic.preOrderRecur(tree: tree)
        print("先序遍历--非递归")
        TreeBasic.preOrderUnRecur(tree: tree)
        print("中序遍历--递归")
        TreeBasic.inOrderRecur(tree: tree)
        print("中序遍历--非递归")
        TreeBasic.inOrderUnRecur(tree: tree)
        print("后序遍历")
        TreeBasic.posOrderRecur(tree: tree)
        print("后序遍历--非递归")
        TreeBasic.posOrderUnRecur(tree: tree)
        print("广度优先遍历")
        TreeBasic.w(head: tree)
        let maxWidth = Question.maxWidth(head: tree)
        let isBst = Question.isBST(head: tree)
        let isCBT = Question.isCBT(head: tree)
        let result = Question.isBstProcess(head: tree)
        XCTAssert(true)
    }
    
    func testTreeNodeBuild() throws {
        let preorder = [8,5,1,7,10,12]
        var index = 0
        let head = TreeNode(val: preorder[index])
        var arr = [TreeNode]()
        arr.append(head)
        index += 1
        while let node = arr.popLast(), index < preorder.count {
            if node.val > preorder[index] {
                let newNode = TreeNode(val: preorder[index])
                node.left = newNode
                arr.append(node)
                arr.append(newNode)
                index += 1
            } else {

                if arr.isEmpty || arr.last!.val > preorder[index] {
                    let newNode = TreeNode(val: preorder[index])
                    node.right = newNode
                    arr.append(newNode)
                    index += 1
                }
            }
        }
        
        XCTAssert(true)
    }
    
    func testSerDser() throws {
        let str = "[1,2,3,null,null,4,5,6,7]"
        let node = Question.deserialize(str)
        XCTAssert(true)
    }
    
    func testMinString() throws {
        let tree = Question.deserialize("[0,1,2,3,4,3,4]")
        let result = Question.smallestFromLeaf(tree)
        XCTAssert(true)
    }
    func testPrintCurse() throws {
        Question.printCrease(curLevel: 1, level: 3, down: true)
        XCTAssert(true)
    }
    
    func testFrogPosition() throws {
        let result = Question.frogProsition(n: 7, edges: [[1,2],[1,3],[1,7],[2,4],[2,6],[3,5]], t: 1, target: 7)
        print(result)
        XCTAssert(true)
    }
    func testFindJudge() throws {
        let reuslt = Question.findJudge(3, [[1,3],[2,3],[3,1]])
        print(reuslt)
        XCTAssert(true)
    }
    
    func testCheapestPath() throws {
        XCTAssert(true)
    }
    
    func testMinHightTree() throws {

        XCTAssert(true)
        
    }
    
    func testMinPath() throws {
        XCTAssert(true)
    }

    func testPriorityQueue() throws {
        let queue = PriorityQueue<Int>(list: [Int]()) { o1, o2 in
            o1 > o2
        }
        queue.push(1)
        queue.push(3)
        queue.push(2)
        print(queue.pop()!)
        print(queue.pop()!)
        print(queue.pop()!)
        XCTAssert(true)
    }
    
    func testKrusalMST() throws {
        let matrix: [MatrixTuple] = [
            (from: 1, to: 2, weight: 3),
            (from: 1, to: 3, weight: 100),
            (from: 1, to: 4, weight: 7),
            (from: 2, to: 3, weight: 5),
            (from: 2, to: 4, weight: 2),
            (from: 3, to: 4, weight: 10000)
        ]
        
        let graph = GraphBase.createGraph(matrixes: matrix, directed: false)
        let edges = Algorithm.krusalMST(graph: graph)
        for edge in edges {
            print(edge.weight)
        }
        XCTAssert(true)
    }
    
    func testPrimMST() throws {
        let matrix: [MatrixTuple] = [
            (from: 1, to: 2, weight: 3),
            (from: 1, to: 3, weight: 100),
            (from: 1, to: 4, weight: 7),
            (from: 2, to: 3, weight: 5),
            (from: 2, to: 4, weight: 2),
            (from: 3, to: 4, weight: 10000)
        ]
        
        let graph = GraphBase.createGraph(matrixes: matrix, directed: false)
        let edges = Algorithm.primMST(graph: graph)
        for edge in edges {
            print(edge.weight)
        }
        XCTAssert(true)
    }
    
    func testDIJkstra() throws {
        let matrix: [MatrixTuple] = [
            (from: 1, to: 2, weight: 3),
            (from: 1, to: 3, weight: 100),
            (from: 1, to: 4, weight: 7),
            (from: 2, to: 3, weight: 5),
            (from: 2, to: 4, weight: 2),
            (from: 3, to: 4, weight: 10000)
        ]
        
        let graph = GraphBase.createGraph(matrixes: matrix, directed: false)
        
        let result = Algorithm.DIJkstra(head: graph.nodes[1]!)
        print(result)
        XCTAssert(true)
    }
    
    func testTrie() {
        let tire = Tire()
        
        tire.insert(word: "abc")
        tire.insert(word: "acd")
        tire.insert(word: "c")
        tire.insert(word: "")
        tire.insert(word: "cds")
        XCTAssert(tire.checkPrefix(word: "c"))
        XCTAssert(!tire.checkPrefix(word: "ab"))
        XCTAssert(tire.checkPrefix(word: "abc"))
        XCTAssert(tire.checkPrefix(word: "abcd"))
        
        XCTAssert(true)
    }
    
    func testMaxSumRangeQuery() throws {
        
        XCTAssert(true)
    }
    
    func testDeleteDumpChar() throws {
        let s = "cbacdcbc"
        let result = Algorithm().removeDuplicateLetters(s)
        print(result)
        XCTAssert(true)
    }
}
