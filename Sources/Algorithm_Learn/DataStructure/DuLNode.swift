//
//  File.swift
//  
//
//  Created by Murph on 2022/6/17.
//

import Foundation

class DuLNode {
    var val: Any
    var next: DuLNode?
    var last: DuLNode?
    
    init(val: Any, next: DuLNode?, last: DuLNode?) {
        self.val = val
        self.next = next
        self.last = last
    }
    
    func reverse() -> DuLNode {
        if self.next == nil { return self }
        var head = self
        var current = self.next
        head.next = nil
        current?.last = nil
        while let temp = current {
            current = temp.next
            current?.last = nil
            temp.next = head
            head.last = temp
            head = temp
        }
        return head
    }
    
    func desc(){
        var node = self
        while let temp = node.next {
            print(node.val)
            node = temp
        }
        print(node.val)
        while let temp = node.last {
            print(node.val)
            node = temp
        }
        print(node.val)
    }
}
