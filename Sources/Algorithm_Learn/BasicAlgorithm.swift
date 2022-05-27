//
//  File.swift
//  
//
//  Created by Murph on 2021/11/11.
//

import Foundation

class BasicAlgorithm {
    
    
    //
    
    // MARK: 二分查找
    static func binarySearch<T: Comparable>(list: Array<T>, target: T) -> Int {
        var left = 0, right = list.count - 1
        while left <= right {
            let mid = (left + right) / 2
            if list[mid] == target {
                return mid
            } else if list[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return left
    }
    
    // MARK: 合并两个有序链表
    static func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else {
            return l2
        }
        guard let l2 = l2 else{
            return l1
        }
        let nextRound1 = l1.next
        let nextRound2 = l2.next
        if l1.val <= l2.val {
            l1.next = mergeTwoLists(nextRound1, l2)
            return l1
        } else {
            l2.next = mergeTwoLists(l1, nextRound2)
            return l2
        }
    }
    
    //MARK: 翻转链表
    static func reverseNodeList(_ head: ListNode?) -> ListNode? {
        if head?.next == nil { return head }
        var current = head?.next
        head?.next = nil
        var result = head
        while let temp = current {
            current = temp.next
            temp.next = result
            result = temp
        }
        return result
    }
}
