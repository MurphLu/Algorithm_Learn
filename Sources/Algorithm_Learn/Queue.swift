//
//  File.swift
//  
//
//  Created by Murph on 2022/4/29.
//

import Foundation

class Queue<T> {
    private class ListNode {
        init(_ val: T){
            self.val = val
        }
        var val: T
        var next: ListNode?
    }
    private(set) var length: Int = 0
    private var head: ListNode?
    private var tail: ListNode?
    
    init() {}
    
    func input(_ val: T) {
        let node = ListNode(val)
        if head == nil {
            head = node
        } else {
            tail?.next = node
        }
        tail = node
        length += 1
    }
    
    func output() -> T? {
        guard let head_ = head else { return nil }
        let val = head_.val
        head = head_.next
        length -= 1
        if head == nil { tail = nil }
        return val
    }
    
    func headVal() -> T? {
        return head?.val
    }
    
    func tailVal() -> T? {
        return tail?.val
    }
    
    
    func isEmpty() -> Bool {
        return length == 0
    }
}
