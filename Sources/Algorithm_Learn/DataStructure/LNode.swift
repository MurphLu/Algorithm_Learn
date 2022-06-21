//
//  LNode.swift
//  
//
//  Created by Murph on 2022/6/17.
//

import Foundation

class LNode <T:Equatable>: Equatable {
    var val: T
    var next: LNode?
    
    init(val: T, next: LNode?) {
        self.val = val
        self.next = next
    }
    
    func reverse() -> LNode {
        if self.next == nil { return self }
        var head = self
        var current = self.next
        head.next = nil
        while let temp = current {
            current = temp.next
            temp.next = head
            head = temp
        }
        return head
    }
    
    func desc() {
        var node: LNode? = self
        while node != nil {
            print(node!.val)
            node = node!.next
        }
    }
    
    var address: String {
        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let addressVal = String(describing: opaque)
        return addressVal
    }
    
    static func ==(lhs: LNode, rhs: LNode) -> Bool {
        return lhs.address == rhs.address
    }
    static func !=(lhs: LNode, rhs: LNode) -> Bool {
        return lhs.address != rhs.address
    }
}
