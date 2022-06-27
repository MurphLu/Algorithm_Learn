//
//  File.swift
//  
//
//  Created by Murph on 2021/10/22.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    func reverse() -> ListNode {
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
}
