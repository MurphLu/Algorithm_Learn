//
//  File.swift
//  
//
//  Created by Murph on 2022/6/23.
//

import Foundation

class TreeNode: Hashable {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(val: Int) {
        self.val = val
    }
    
    var address: String {
        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let addressVal = String(describing: opaque)
        return addressVal
    }
    
    static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.address == rhs.address
    }
    static func !=(lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.address != rhs.address
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.address)
        hasher.finalize()
    }
}

class TreeBasic {
    // 递归序
    public static func recursiveTravel(tree: TreeNode?) {
        guard let tree = tree else { return }
        recursiveTravel(tree: tree.left)
        recursiveTravel(tree: tree.right)
    }
    
    // 先序遍历（头左右）
    public static func preOrderRecur(tree: TreeNode?) {
        guard let tree = tree else { return }
        print(tree.val)
        preOrderRecur(tree: tree.left)
        preOrderRecur(tree: tree.right)
    }
    
    // 中序遍历（左头右）
    public static func inOrderRecur(tree: TreeNode?) {
        guard let tree = tree else { return }
        inOrderRecur(tree: tree.left)
        print(tree.val)
        inOrderRecur(tree: tree.right)
    }
    
    //后序遍历（左右头）
    public static func posOrderRecur(tree: TreeNode?) {
        guard let tree = tree else { return }
        posOrderRecur(tree: tree.left)
        posOrderRecur(tree: tree.right)
        print(tree.val)
    }
    
    
    //非递归
    // 先序遍历（头左右）
    /**
     头节点进栈，
     出栈，打印，并将出栈节点的右节点进栈（如果有），左节点进栈（如果有），
     周而复始，直到栈为空
     */
    public static func preOrderUnRecur(tree: TreeNode?) {
        guard let head = tree else { return }
        var arr = [TreeNode]()
        arr.append(head)
        while let node = arr.popLast() {
            print(node.val)
            if let right = node.right {
                arr.append(right)
            }
            if let left = node.left {
                arr.append(left)
            }
        }
    }
    
    // 中序遍历（左头右）
    /**
     每棵子树，整棵树左边界进栈，
     依次弹出过程中，打印
     查看弹出节点是否有右节点
     如果有，对右节点构成的树进行左边界进栈，再继续
     没有，继续下一轮弹出
     */
    public static func inOrderUnRecur(tree: TreeNode?) {
        guard let tree = tree else { return }
        var stack = [TreeNode]()
        func appendAllLeft(head: TreeNode?) {
            var cur = head
            while let cur_ = cur {
                stack.append(cur_)
                cur = cur_.left
            }
        }
        appendAllLeft(head: tree)
        while let last = stack.popLast() {
            print(last.val)
            if let right = last.right {
                appendAllLeft(head: right)
            }
        }
    }
    
    //后序遍历（左右头）
    /**
     将头节点进栈，
     出栈过程中，将出栈的节点压入收集栈，并将弹出节点，先左后右的方式入栈，
     周而复始
     最终打印用收集栈打印
     收集栈的进栈顺序为头右左，最终打印的顺序为 左右头
     */
    public static func posOrderUnRecur(tree: TreeNode?) {
        guard let tree = tree else { return }
        var collect = [TreeNode]()
        var stack = [TreeNode]()
        stack.append(tree)
        while let last = stack.popLast() {
            collect.append(last)
            if let left = last.left {
                stack.append(left)
            }
            if let right = last.right {
                stack.append(right)
            }
        }
        while let last = collect.popLast() {
            print(last.val)
        }
    }
    
    public static func w(head: TreeNode) {
        let queue = Queue<TreeNode>()
        queue.input(head)
        while !queue.isEmpty() {
            guard let node = queue.output() else { return }
            print(node.val)
            if let left = node.left {
                queue.input(left)
            }
            if let right = node.right {
                queue.input(right)
            }
        }
    }
}
