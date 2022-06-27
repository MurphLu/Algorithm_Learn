//
//  Question.tree.swift
//  
//
//  Created by Murph on 2022/6/24.
//

import Foundation



extension Question {
    typealias NodeLevel = (node: TreeNode, level: Int)
    /**
     树的最大宽度
     */
    public static func maxWidth(head: TreeNode) -> Int{
        let queue = Queue<NodeLevel>()
        
        var currentLevel: Int = -1
        currentLevel += 1
        var maxWidth = -1
        var currentLength = 0
        queue.input((head, currentLevel))
        currentLength += 1
        while let val = queue.output() {
            if currentLevel == val.level {
                currentLength += 1
            } else {
                maxWidth = max(currentLength, maxWidth)
                currentLevel += 1
                currentLength = 1
            }
            if let left = val.node.left {
                queue.input((left, val.level + 1))
            }
            if let right = val.node.right {
                queue.input((right, val.level + 1))
            }
        }
        maxWidth = max(currentLength, maxWidth)
        return maxWidth
    }
    
    /**
     是否为搜索二叉树
     搜索二叉树：(Binary Search Tree)
        1. 为空树
        2. 如果它的左子树不为空，那么 左子树上所有的节点均小于根节点的值
        3. 如果它的右子树不为空，那么 右子树上所有的节点均大于根节点的值
     
     那么 中序遍历必为升序
     */
    static var lastVal: Int?
    public static func isBST(head: TreeNode?) -> Bool {
        guard let head = head else { return true }
        if(!isBST(head: head.left)) { return false }
        guard let lastVal = lastVal else {
            lastVal = head.val
            return true
        }
        if head.val <= lastVal { return false }
        self.lastVal = head.val
        return isBST(head: head.right)
    }
    
    
    /**
     完全二叉树（Complete Binary Tree）
     完全二叉树的特点：叶子结点只能出现在最下层和次下层，且最下层的叶子结点集中在树的左部。需要注意的是，满二叉树肯定是完全二叉树，而完全二叉树不一定是满二叉树
              1
            /   \
           2     3
          / \    /
         4   5   6
     
             1
           /   \
          2     3
         / \    / \
        4   5   6  7
     
             1
           /   \
          2     3
         / \
        4   5
     
     判断一棵树是否是完全二叉树的思路
     如果为空，则直接返回 false
     宽度优先遍历：
     任一节点的右孩子为空，左孩子不为空，直接返回 false
     任一节点左孩子不为空，右孩子为空，那么这个节点之后的任一节点都必须是叶子节点
     */
    public static func isCBT(head: TreeNode?) -> Bool {
        guard let head = head else { return false }
        let queue = Queue<TreeNode>()
        queue.input(head)
        var meetSingleLeaf = false
        while let node = queue.output() {
            if meetSingleLeaf && (node.left != nil || node.right != nil) {
                return false
            }
            if let left = node.left {
                queue.input(left)
            }
            if let right = node.right {
                if node.left == nil { return false }
                queue.input(right)
            }
            if node.left == nil || node.right == nil {
                meetSingleLeaf = true
            }
        }
        return true
    }
    
    // 二叉树套路，递归
    typealias BstReturnData = (isBst: Bool, min: Int, max: Int)
    public static func isBstProcess(head: TreeNode?) -> BstReturnData?{
        guard let head = head else { return nil }
        let leftData = isBstProcess(head.left)
        let rightData = isBstProcess(head.right)
        var max_ = head.val
        var min_ = head.val
        if let leftData = leftData {
            min_ = min(min_, leftData.min)
            max_ = max(max_, leftData.max)
        }
        if let rightData = rightData {
            max_ = max(max_, rightData.max)
            min_ = min(min_, rightData.min)
        }
        var isBst = true
        if let leftData = leftData, (!leftData.isBst || leftData.max >= head.val) {
            isBst = false
        }
        if let rightData = rightData, (!rightData.isBst || rightData.min <= head.val) {
            isBst = false
        }
        return (isBst, min_, max_)
    }
    
    /**
     一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过 1
     */
    typealias BalanceReturnData = (isBalance: Bool, level: Int)
    public static func isBalanceProcess(head: TreeNode?) -> BalanceReturnData {
        guard let root = head else { return (true, 0) }
        let leftInfo = isBalanceProcess(head: root.left)
        let rightInfo = isBalanceProcess(head: root.right)
        
        if leftInfo.isBalance && rightInfo.isBalance && abs(leftInfo.level - rightInfo.level) < 2 {
            return (true, max(leftInfo.level, rightInfo.level) + 1)
        }
        return (false, max(leftInfo.level, rightInfo.level) + 1)
    }
    
    
    /**
     full tree
     */
    public static func isFullTree(head: TreeNode?) {
        let info = treeInfoProcess(head: head)
        if info.nodes = 2 << info.height - 1
    }
    
    typealias treeInfo = (nodes: Int, height: Int)
    public static func treeInfoProcess(head: TreeNode?) -> treeInfo {
        guard let root = head else { return (0, 0) }
        let leftInfo = isFullTreeProcess(head: root.left)
        let rightInfo = isFullTreeProcess(head: root.right)
        let nodes = leftInfo.nodes + rightInfo.nodes
        let height = max(leftInfo.height + rightInfo.height) + 1
        return (nodes, height)
    }
    
    /**
     树形DP
     */
}

