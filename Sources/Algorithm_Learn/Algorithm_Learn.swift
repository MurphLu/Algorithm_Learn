/**
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/add-two-numbers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

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
}
