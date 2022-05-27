//
//  File.swift
//  
//
//  Created by Murph on 2022/4/29.
//

import Foundation

class Queue {
    private(set) var length: Int = 0
    private var head: ListNode?
    private var tail: ListNode?
    
    init() {
        
    }
    
    func input(_ val: Int) {
        let node = ListNode(val)
        if head == nil {
            head = node
        } else {
            tail?.next = node
        }
        tail = node
        length += 1
    }
    
    func output() -> Int? {
        let temp = head
        if head != nil {
            head = temp?.next
            length -= 1
        }
        if head == nil {
            tail = nil
        }
        return temp?.val
    }
    
    func headVal() -> Int? {
        return head?.val
    }
    
    func tailVal() -> Int? {
        return tail?.val
    }
}
