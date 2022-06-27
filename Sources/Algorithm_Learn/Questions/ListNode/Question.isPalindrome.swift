//
//  Question.isPalindrome.swift
//  
//
//  Created by Murph on 2022/6/20.
//

import Foundation

/**
 一个单链表是否为回文，
 不要求空间复杂度，时间复杂度为 O(N)，遍历后用栈来保存链表值，通过出栈来对比
 时间复杂度O(N)，空间复杂度 O(1) 找中点，后半部分逆序，然后对比
 找中点过程，快慢指针，慢指针一步，快指针两步
 */

typealias LNodeCenters = (center: LNode<Int>?, centerL: LNode<Int>?, centerR: LNode<Int>?)

extension Question {
    
    private static func nodeCenter(list: LNode<Int>) -> LNodeCenters {
        var n1 = list
        var n2 = list
        while let newN1 = n1.next, let newN2 = n2.next?.next {
            n1 = newN1
            n2 = newN2
        }
        
        var center: LNode<Int>?
        var centerL: LNode<Int>?
        var centerR: LNode<Int>?
        if n2.next == nil {
            center = n1
        } else {
            centerL = n1
            centerR = n1.next
        }
        return LNodeCenters(center, centerL, centerR)
    }
    
    private static func valStackFromNode(listNode: LNode<Int>) -> [Int] {
        var stack = [Int]()
        var temp = listNode
        stack.append(listNode.val)
        while let next = temp.next {
            stack.append(next.val)
            temp = next
        }
        return stack
    }
    
    public static func isPalindromeFullStack(listNode: LNode<Int>) -> Bool{
        if listNode.next == nil { return true }
        if listNode.next?.next == nil {
            return listNode.val == listNode.next!.val
        }
        var stack = valStackFromNode(listNode: listNode)
        
        var tempNew = listNode
        if listNode.val != stack.popLast() { return false }
        
        while let next = tempNew.next {
            if !(next.val == stack.popLast()) {
                return false
            }
            tempNew = next
        }
        
        return true
    }
    
    public static func isPalindromeHalfStack(listNode: LNode<Int>) -> Bool {
        if listNode.next == nil { return true }
        if listNode.next?.next == nil {
            return listNode.val == listNode.next!.val
        }
        let centers = nodeCenter(list: listNode)
        var stack = [Int]()
        if let center = centers.center {
             stack = valStackFromNode(listNode: center.next!)
        }else if let _ = centers.centerL, let centerR = centers.centerR {
            stack = valStackFromNode(listNode: centerR)
        }
        var temp = listNode
        while !stack.isEmpty {
            if stack.popLast() != temp.val { return false }
            temp = temp.next!
        }
        return true
    }

    public static func isPalindromeO1(listNode: LNode<Int>) -> Bool {
        if listNode.next == nil { return true }
        if listNode.next?.next == nil {
            return listNode.val == listNode.next!.val
        }
        
        let centers = nodeCenter(list: listNode)
        var tailNode: LNode<Int>!
        if let center = centers.center {
            tailNode = center.next!.reverse()
            center.next = nil
        }else if let centerL = centers.centerL, let centerR = centers.centerR {
            centerL.next = nil
            tailNode = centerR.reverse()
        }
        if listNode.val != tailNode.val { return false }
        var  headList = listNode
        var tailList = tailNode
        while let next = headList.next, let tailNext = tailList!.next {
            if next.val != tailNext.val { return false }
            headList = headList.next!
            tailList = tailList?.next!
        }
        if let center = centers.center {
            center.next = tailNode.reverse()
        }else if let centerL = centers.centerL, let _ = centers.centerR {
            centerL.next = tailNode.reverse()
        }
        return true
    }
}
