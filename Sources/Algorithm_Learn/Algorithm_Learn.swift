/**
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import Foundation

public struct Algorithm_Learn {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    /**
     1. 两数之和
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

     你可以按任意顺序返回答案。
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dic = [Int: Int]()
        for (index, item) in nums.enumerated() {
            dic[item] = index
        }
        for (index, item) in nums.enumerated() {
            if let i2 = dic[target-item], index != i2 {
                return [index, i2]
            }
        }
        return [Int]()
    }
    
    /**
     2. 两数相加
    给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

    请你将两个数相加，并以相同形式返回一个表示和的链表。

    你可以假设除了数字 0 之外，这两个数都不会以 0 开头。
    */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil { return l2 }
        if l2 == nil { return l1 }
        return addTwoNode(l1, l2, aditionalVal: 0)
    }
    
    private func addTwoNode(_ l1: ListNode?, _ l2: ListNode?, aditionalVal: Int) -> ListNode? {
        var result: ListNode?
        if l1 == nil && l2 == nil {
            result = aditionalVal == 0 ? nil : ListNode(aditionalVal)
        } else {
            let targetVal = (l1?.val ?? 0) + (l2?.val ?? 0) + aditionalVal
            result = ListNode(targetVal % 10)
            let nextAdditional = targetVal / 10
            
            result?.next = addTwoNode(l1?.next, l2?.next, aditionalVal: nextAdditional)
        }
        return result
    }
    
    /**
     3. 无重复字符串的最长子串
     
     给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count <= 1 {
            return s.count
        }
        let charArr = Array(s)
        var startIndex = 0
        var endIndex = 1
        var maxLength = 1
        while endIndex < charArr.count {
            let nextChar = charArr[endIndex]
            if let nextStartIndex = (charArr[startIndex...(endIndex - 1)]).lastIndex(of: nextChar) {
                startIndex = nextStartIndex + 1
                endIndex += 1
                continue
            } else {
                let currentLength = endIndex - startIndex + 1
                if maxLength < currentLength {
                    maxLength = currentLength
                }
                endIndex += 1
            }
        }

        return maxLength
    }
    
    /**
     4. 寻找两个正序数组的中位数
     
     给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。
     */
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        if nums1.count > nums2.count { return findMedianSortedArrays(nums2, nums1)}
        let m = nums1.count
        let n = nums2.count
        
        //左边界初始值为0
        var left = 0
        //左边界初始值为短数组的长度
        var right = m
        
        var median1 = 0, median2 = 0
        
        while left <= right {
            //数组 1 的中间位置
            let i = (left + right) / 2
            // 数组 2
            let j = (m + n + 1) / 2 - i
            let nums_im1 = i == 0 ? Int.min : nums1[i-1]
            let nums_i = i == m ? Int.max : nums1[i]
            let nums_jm1 = j == 0 ? Int.min : nums2[j - 1]
            let nums_j = j == n ? Int.max : nums2[j]
            
            if nums_im1 <= nums_j {
                median1 = max(nums_im1, nums_jm1)
                median2 = min(nums_i, nums_j)
                left = i + 1
            } else {
                right = i - 1
            }
        }
        return (m + n) % 2 == 0 ? Double(median1 + median2) / 2.0 : Double(median1)
    }
    
    /**
     20. 有效的括号
     给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

     有效字符串需满足：

     左括号必须用相同类型的右括号闭合。
     左括号必须以正确的顺序闭合。
     */
    func isValid(_ s: String) -> Bool {
        let bracketsMap = [
            "(": 1,
            ")": -1,
            "[": 2,
            "]": -2,
            "{": 3,
            "}": -3
        ]
        
        if s.count <= 1 { return false }
        var arr = [Int]()
        for i in 0 ..< s.count {
            let currentChar = (s as NSString).substring(with: NSRange(location: i, length: 1))
            let currentNum = bracketsMap[currentChar]!
            if arr.count >= 1, arr.last! < currentNum, arr.last! + currentNum == 0{
                arr.removeLast()
            } else {
                arr.append(currentNum)
            }
        }
        return arr.isEmpty
    }
    
    /**
     32. 最长有效括号
     给你一个只包含 '(' 和 ')' 的字符串，找出最长有效（格式正确且连续）括号子串的长度。
     */
    func longestValidParentheses(_ s: String) -> Int {
        let bracketsMap = [
            "(": 1,
            ")": -1,
        ]
        var tempList = [Int]()
        var matchedIndex = [Int]()
        let list = Array(s)
        for i in 0..<s.count {
            if tempList.isEmpty { tempList.append(i) } else {
                if bracketsMap[String(list[tempList.last!])]! > 0 &&
                    (bracketsMap[String(list[tempList.last!])]! + bracketsMap[String(list[i])]! == 0) {
                    matchedIndex.append(tempList.popLast()!)
                    matchedIndex.append(i)
                } else {
                    tempList.append(i)
                }
            }
        }
        var tempLength = 0
        var result = 0
        if matchedIndex.count < 2 { return 0 }
        matchedIndex.sort()
        for i in 0..<matchedIndex.count - 1 {
            if matchedIndex[i] + 1 == matchedIndex[i + 1] {
                tempLength += 1
                if i == matchedIndex.count - 2 {
                    result = result < tempLength ? tempLength : result
                }
            } else {
                result = result < tempLength ? tempLength : result
                tempLength = 0
            }
        }
        return result + 1
    }
    
    /**
     19. 删除链表的倒数第 N 个结点
     给你一个链表，删除链表的倒数第 n 个结点，并且返回链表的头结点。
     */
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head?.next == nil, n == 1 {
            return nil
        }
        var tempLength = 0
        var tempNode: ListNode? = head
        var currentNode: ListNode? = head
        while let next = currentNode?.next {
            if tempLength == n {
                tempNode = tempNode?.next
                currentNode = next
                continue
            }
            currentNode = next
            tempLength += 1;
        }
        if tempLength == n-1 {
            return head?.next
        }
        let nodeToRemove = tempNode?.next
        tempNode?.next = nodeToRemove?.next
        nodeToRemove?.next = nil
        return head
    }
    
    /**
     21. 合并两个有序链表
     将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
     */
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil { return l2 }
        if l2 == nil { return l1 }
        return generateNextVal(l1, l2)
    }
    
    private func generateNextVal(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else {
            return l2
        }
        guard let l2 = l2 else{
            return l1
        }
        let nextRound1 = l1.next
        let nextRound2 = l2.next
        if l1.val <= l2.val {
            l1.next = generateNextVal(nextRound1, l2)
            return l1
        } else {
            l2.next = generateNextVal(l1, nextRound2)
            return l2
        }
        
    }
    
    /**
     23. 合并K个升序链表
     给你一个链表数组，每个链表都已经按升序排列。
     请你将所有链表合并到一个升序链表中，返回合并后的链表。
     */
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if lists.count == 0 { return nil }
        if lists.count == 1 { return lists[0] }
        var node: ListNode? = mergeTwoLists(lists[0], lists[1])
        if lists.count == 2 { return node }
        for i in 2..<lists.count {
            node = mergeTwoLists(node, lists[i])
        }
        return node
    }
    
    /**
     237. 删除链表中的节点
     请编写一个函数，用于 删除单链表中某个特定节点 。在设计函数时需要注意，你无法访问链表的头节点 head ，只能直接访问 要被删除的节点 。
     题目数据保证需要删除的节点 不是末尾节点 。
     */
    func deleteNode(_ node: ListNode?) {
        guard let node = node, let next = node.next else { return }
        node.val = next.val
        node.next = next.next
        next.next = nil
    }
    
    /**
     89. 格雷编码
     n 位格雷码序列 是一个由 2n 个整数组成的序列，其中：
     每个整数都在范围 [0, 2n - 1] 内（含 0 和 2n - 1）
     第一个整数是 0
     一个整数在序列中出现 不超过一次
     每对 相邻 整数的二进制表示 恰好一位不同 ，且
     第一个 和 最后一个 整数的二进制表示 恰好一位不同
     给你一个整数 n ，返回任一有效的 n 位格雷码序列 。
     */
    func grayCode(_ n: Int) -> [Int] {
        var result = [Int]()
        for i in 0..<1<<n {
            result.append(i^i>>1)
        }
        return result
    }
    
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        return BasicAlgorithm.binarySearch(list: nums, target: target)
    }
    
    
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        return 0
    }
    /**
    61. 旋转链表
    给你一个链表的头节点 head ，旋转链表，将链表每个节点向右移动 k 个位置。
     
     链表中节点的数目在范围 [0, 500] 内
     -100 <= Node.val <= 100
     0 <= k <= 2 * 109
     */
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        if head?.next == nil || k == 0 {
            return head
        }
        var tempNode = head
        var count = head == nil ? 0 : 1
        while let next = tempNode?.next {
            tempNode = next
            count += 1
        }
        let rotateK = k % count
        if rotateK == 0 {return head}
        var tempTail = head
        tempNode = head
        var count2 = 0
        while let next = tempNode?.next {
            if count2 == rotateK {
                tempTail = tempTail?.next
            } else {
                count2 += 1
            }
            tempNode = next
        }
        
        let newHead = tempTail?.next
        tempTail?.next = nil
        
        tempTail = newHead
        while tempTail?.next != nil {
            tempTail = tempTail?.next
        }
        tempTail?.next = head
        return newHead
    }
    
    /**
     给你两个二进制字符串，返回它们的和（用二进制表示）。

     输入为 非空 字符串且只包含数字 1 和 0。
     */
    func addBinary(_ a: String, _ b: String) -> String {
        var result = ""
        var temp = 0
        var strA = a
        var strB = b
        while !strA.isEmpty || !strB.isEmpty {
            let charA = Int(String(strA.popLast() ?? Character("0"))) ?? 0
            let charB = Int(String(strB.popLast() ?? Character("0"))) ?? 0
            let tempResult = charA + charB + temp
            temp = 0
            result.append("\(tempResult % 2)")
            if tempResult > 1 {
                temp = 1
            }
        }
        if temp == 1 {result.append("\(temp)")}
        return String(result.reversed())
    }
    
    func reverse(_ x: Int) -> Int {
        if x > -10 && x < 10 {return x}
        var str = String(x)
        var tempSimble = false
        if str.first == "-" {
            tempSimble = true
            let _ = str.removeFirst()
        }
        var characters = Array(str)
        var index = 0
        var temp:Character!
        while index < characters.count / 2 {
            temp = characters[index]
            characters[index] = characters[characters.count - 1 - index]
            characters[characters.count - 1 - index] = temp
            index += 1
        }
        while characters.first == Character("0") {
            characters.removeFirst()
        }
        if tempSimble {
            characters.insert(Character("-"), at: 0)
        }
        let result = Int(Int32(String(characters)) ?? 0)
        return result
    }
    
    func myAtoi(_ s: String) -> Int {
        if s.isEmpty { return 0 }
        let characters = Array(s)
        var temp = Array<Character>()
        var index = 0
        var numStarted = false
        var isNigative = false
        while index < characters.count {
            let char = characters[index]
            if numStarted && Int(String(char)) == nil {
                break
            }
            index += 1
            if char == Character(" ") {continue}
            if char == Character("-") || char == Character("+"){
                numStarted = true
                isNigative = char == Character("-")
                continue
            }
            if Int(String(char)) != nil {
                numStarted = true
                temp.append(char)
            } else {
                break
            }
        }
        while temp.first == Character("0") {
            temp.removeFirst()
        }
        if temp.isEmpty { return 0 }
        if isNigative { temp.insert(Character("-"), at: 0)}
        let result = Int(Int32(String(temp)) ?? (isNigative ? -INT32_MAX - Int32(1) : INT32_MAX))
        return result
    }
    
    func removeOuterParentheses(_ s: String) -> String {
        let chars = Array(s)
        var result = ""
        var index = s.count - 1
        var state = 0
        while index != 0 {
            if chars[index] == Character(")") {
                state += 1
                if state == 1 {
                    index -= 1
                    continue
                }
            }
            if chars[index] == Character("(") {
                state -= 1
                if state == 0 {
                    index -= 1
                    continue
                }
            }
            result.append(chars[index])
        }
        var list = [1,2]
        return result
    }
}

class RecentCounter {

    init() {

    }
    let queue = Queue()
    func ping(_ t: Int) -> Int {
        queue.input(t)

        while queue.length > 1 && queue.headVal()! < t-3000 {
            _ = queue.output()
        }
        return queue.length
    }
}
