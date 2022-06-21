//
//  File.swift
//  
//
//  Created by Murph on 2022/6/21.
//

import Foundation

/**
 给定两个可能有环也可能无环的单链表，头结点 head1 和 head2，请实现一个函数，如果两个链表相交，请返回第一个节点，如果不相交，返回 null
 两个链表长度之和 N，时间复杂度要求 O(N)，额外空间复杂度 O(1)
 
 !!!! 链表是否有环，额外空间复杂度 O(1)
 两个指针，快指针（一次两步），慢指针（一次一步），两个指针同时开始走，一定会在环上相遇，
 相遇之后快指针回到 head，然后两个指针一起一次一步向下遍历，最终两个指针会在入环处相遇
 !!!!!!
 */


extension Question {
    public static func getLoopNode(head: LNode<Int>) -> LNode<Int>? {
        var slow = head.next
        var fast = head.next?.next
        while let slow_ = slow?.next, let fast_ = fast?.next?.next {
            if slow_ == fast_ {
                fast = head
                slow = slow_
                break
            }
            slow = slow_
            fast = fast_
        }
        if fast?.next?.next == nil { return nil }
        while slow != fast {
            slow = slow?.next
            fast = fast?.next
        }
        return slow
    }
    
    /**
     无环：
        遍历两个链表，获取两个链表长度，对比尾结点是否相同，不相同那么没有共用节点，相同则继续
        两个链表如果有公共部分，那么这部分一直到最后节点一定是共用的
        然后重新遍历，长链表先走差值步，然后短链表同长链表一起遍历，然后两个指针一定在第一个相交节点相遇
     
     
     一个有环一个无环：
        一定不相交
     
     有环：
        1) 各自独立
        2) 入环节点是一个（干掉环，然后用无环的方式）
        3) 入环节点是两个（）
        情况 1,3 区分，loop1 继续遍历，如果与 loop2 相遇，则为 3，否则为 1，
        如果为情况3，那么 loop1 与 loop2 都可以称作相交第一个节点
     */
    public static func getSharedNodeEnter(head1: LNode<Int>, head2: LNode<Int>) -> LNode<Int> {
        let loop1 = getLoopNode(head: head1)
        let loop2 = getLoopNode(head: head2)
        
        if loop1 == nil && loop2 == nil {
            return getFirstShareNodeNoLoop(head1: head1, head2: head2)
        } else if loop1 != nil && loop2 != nil {
            if loop1 == loop2 (
                return getFirstShareNodeSameLoopNode(head1: head1, head2: head2)
            ) else {
                return getFirstShareNodeDiffLoopNode(head1: head1, head2: head2)
            }
        }
        return nil
    }
    
    public static func getFirstShareNodeNoLoop(head1: LNode<Int>, head2: LNode<Int>) -> LNode<Int>? {
        let tailAndLength1 = self.getNodeListTailAndLength(head: head1)
        let tailAndLength2 = self.getNodeListTailAndLength(head: head2)
        if tailAndLength1.0 != tailAndLength2.0 { return nil }
        var cur1: LNode<Int>? = tailAndLength1.1 > tailAndLength2.1 ? head1 : head2
        var cur2: LNode<Int>? = tailAndLength1.1 <= tailAndLength2.1 ? head1 : head2
        var distance = abs(tailAndLength2.1 - tailAndLength1.1)
        while distance > 0 {
            cur1 = cur1?.next
            distance -= 1
        }
        while cur1 != cur2 {
            cur1 = cur1?.next
            cur2 = cur2?.next
        }
        return cur1
    }
    
    public static func getFirstShareNodeDiffLoopNode(head1: LNode<Int>, head2: LNode<Int>) -> LNode<Int>? {
        var enter1 = getLoopNode(head: head1)
        var temp = enter1?.next
        
        var enter2 = getLoopNode(head: head2)
        
        while temp != enter1, temp != enter2 {
            temp = temp?.next
        }
        if temp != enter2 { return nil}
        return enter1 // return enter2 都可
    }
    
    public static func getFirstShareNodeSameLoopNode(head1: LNode<Int>, head2: LNode<Int>) -> LNode<Int>? {
        var enter = getLoopNode(head: head1)
        var temp = enter?.next
        enter?.next = nil
        let result = getFirstShareNodeNoLoop(head1: head1, head2: head2)
        enter?.next = temp
        return result
    }
    
    public static func getNodeListTailAndLength(head: LNode<Int>) -> (LNode<Int>, Int) {
        var cur = head
        var length = 1
        while let next = cur.next {
            length += 1
            cur = next
        }
        return (cur, length)
    }
}
