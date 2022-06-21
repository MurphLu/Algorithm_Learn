//
//  Question.cloneListNodeWithRandomPoint.swift
//  
//
//  Created by Murph on 2022/6/20.
//

import Foundation

/**
 克隆一个带 random 指针的链表，要求时间复杂度为 O(N)
 Dic, 空间复杂度 O(N)
 将克隆后的每个节点插入到被克隆节点的 next 位置，这样可以利用相对位置来找到对应的克隆节点的 random 位置，克隆完恢复
 */
class LNodeWithRandom<T: Equatable> {
    var val: T
    var next: LNodeWithRandom<T>?
    var random: LNodeWithRandom<T>?
    
    init(val: T, next: LNodeWithRandom?) {
        self.val = val
        self.next = next
    }
    var address: String {
        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let addressVal = String(describing: opaque)
        return addressVal
    }
}

extension Question {
    public static func copyNodeListWithStack(listNode: LNodeWithRandom<Int>) -> LNodeWithRandom<Int> {
        var map = [String: LNodeWithRandom<Int>]()
        var temp = listNode
        map[temp.address] = temp
        while let next = temp.next {
            map[next.address] = next
            temp = next
        }
        
        temp = listNode
        let head = LNodeWithRandom(val: temp.val, next: nil)
        var next = head
        head.random = map[temp.random?.address ?? ""]
        while let tempNext = temp.next {
            let node = LNodeWithRandom(val: tempNext.val, next: nil)
            node.random = map[tempNext.random?.address ?? ""]
            next.next = node
            next = node
            temp = tempNext
        }
        return head
    }
    
    public static func copyNodeListO1(listNode: LNodeWithRandom<Int>) -> LNodeWithRandom<Int> {
        var node:LNodeWithRandom<Int>? = listNode
        
        while let next = node?.next {
            let newNode = LNodeWithRandom(val: node!.val, next: next)
            node!.next = newNode
            node = next
        }
        let newNode = LNodeWithRandom(val: node!.val, next: nil)
        node!.next = newNode
        
        node = listNode
        
        
        while let next = node?.next {
            next.random = node?.random?.next
            node = next.next
        }
        
        node = listNode
        
        let header: LNodeWithRandom<Int>? = node?.next
        node?.next = header?.next
        var current: LNodeWithRandom<Int>? = header
        header?.next = nil
        node = node?.next

        while let next = node?.next {
            node!.next = next.next
            current!.next = next
            node = next.next
            current = current!.next
            current!.next = nil
        }
        return header!
    }
}

