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
        let leftData = isBstProcess(head: head.left)
        let rightData = isBstProcess(head: head.right)
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
        if info.nodes == 2 << info.height - 1 {}
    }
    
    typealias treeInfo = (nodes: Int, height: Int)
    public static func treeInfoProcess(head: TreeNode?) -> treeInfo {
        guard let root = head else { return (0, 0) }
        let leftInfo = treeInfoProcess(head: root.left)
        let rightInfo = treeInfoProcess(head: root.right)
        let nodes = leftInfo.nodes + rightInfo.nodes
        let height = max(leftInfo.height, rightInfo.height) + 1
        return (nodes, height)
    }
    
    // 二叉树查找
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return nil }
        if root.val < val {
            return searchBST(root.right, val)
        } else if root.val > val {
            return searchBST(root.left, val)
        } else {
            return root
        }
    }
    
    /**
    查找最低公共祖先节点
    或者遍历将节点与父节点存入 map 中，然后将两个节点向上找到所有节点，然后很容易就找到最低公共父节点
     */
    public func lowestCommonAncestor(_ root: TreeNode, _ p: TreeNode , _ q: TreeNode) -> TreeNode {
            let result = lowestCommonAncestorProcess(root, p, q)!
            return result
        }
    func  lowestCommonAncestorProcess(_ root: TreeNode?, _ p: TreeNode , _ q: TreeNode) -> TreeNode? {
        guard let root = root else { return nil }
        if root.val == p.val || root.val == q.val { return root }
        let leftResult = lowestCommonAncestorProcess(root.left, p, q);
        let rightResult = lowestCommonAncestorProcess(root.right, p, q);
        if (leftResult != nil) && (rightResult != nil) {
            return root;
        }
        return leftResult == nil ? rightResult : leftResult;
    }
    
    /**
     有序数组转平衡二叉树
     */
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return sortedArrayToBST(nums, 0, nums.count - 1)
    }

    func sortedArrayToBST(_ nums: [Int], _ startIndex: Int, _ endIndex: Int) -> TreeNode? {
        if startIndex > endIndex { return nil }
        if startIndex == endIndex { return TreeNode(val: nums[startIndex]) }
        let center = startIndex + (endIndex - startIndex) / 2
        let root = TreeNode(val: nums[center])
        let left = sortedArrayToBST(nums, startIndex, center - 1)
        let right = sortedArrayToBST(nums, center + 1, endIndex)
        root.left = left
        root.right = right
        return root
    }
    
    /**
     二叉树序列化
     */
    public static func serialize(_ root: TreeNode?) -> String {
        if root?.left == nil && root?.right == nil { return "[\(root != nil ? "\(root!.val)" : "")]"}
        var result = [root]
        serialize(&result, lastLevelCount: 1, lastLevelSize: 1)
        let values = result.map({$0?.val})
        var str = "["
        for i in values {
            str.append("\(i == nil ? "null" : "\(i!)"),")
        }
        str.removeLast()
        str += "]"
        return str
    }

    static func serialize(_ arr: inout [TreeNode?], lastLevelCount: Int, lastLevelSize: Int) {
        var currentIndex = lastLevelSize - lastLevelCount
        var shouldNextRound = false
        var curLevelCount = 0
        while currentIndex < lastLevelSize {
            if let node = arr[currentIndex] {
                arr.append(node.left)
                arr.append(node.right)
                if node.left?.left != nil || node.left?.right != nil || node.right?.left != nil || node.right?.right != nil {
                    shouldNextRound = true
                }
                curLevelCount += 2
            }
            currentIndex += 1
        }
        if shouldNextRound {
            serialize(&arr, lastLevelCount: curLevelCount, lastLevelSize: arr.count)
        }
    }
    
    /**
     二叉树反序列化
     */
    public static func deserialize(_ data: String) -> TreeNode? {
        var str = data
        str.removeLast()
        str.removeFirst()
        if str.isEmpty { return nil }
        var arr = str.split(separator: ",").reversed().map({String($0)})
        let head = TreeNode(val: Int(arr.popLast()!)!)
        deserialize(head: head, arr: &arr)
        return head
    }
    
    static func deserialize(head: TreeNode, arr: inout [String]){
        let queue: Queue<TreeNode?> = Queue<TreeNode?>()
        queue.input(head)
        while !queue.isEmpty() && !arr.isEmpty{
            guard let last = queue.output(), last != nil else { continue }
           
            let valLeft = Int(arr.popLast() ?? "")
            let left = valLeft == nil ? nil : TreeNode(val: valLeft!)
            let valRight = Int(arr.popLast() ?? "")
            let right = valRight == nil ? nil : TreeNode(val: valRight!)
            queue.input(left)
            queue.input(right)
            last?.left = left
            last?.right = right
        }
    }
    
    /**
     由叶到根最小字符串
     */
    static let arr = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    public static func smallestFromLeaf(_ root: TreeNode?) -> String {
        let result = smallestFromLeafArr(root)
        if result.isEmpty { return "" }
        return result[0]
        // return leftVal < rightVal ? leftVal : rightVal
    }

    static func smallestFromLeafArr(_ root: TreeNode?) -> [String] {
        guard let root = root else { return [String]() }
        let left = smallestFromLeafArr(root.left)
        let right = smallestFromLeafArr(root.right)
        let leftVal = left.map({"\($0)\(arr[root.val])"})
        let rightVal = right.map({"\($0)\(arr[root.val])"})
        var result = leftVal
        result.append(contentsOf: rightVal)
        if result.isEmpty { return [arr[root.val]] }
        result.sort()
        var endIndex = 0
        while endIndex < result.count - 1 {
            if result[endIndex+1].hasPrefix(result[endIndex]) {
                endIndex += 1
            } else {
                break
            }
        }
        return Array(result[0...endIndex])
    }
    
    /**
     一个纸条，对折 N 次，
     第一个折痕为 凹 的话，由上到下打印折痕类型 （凹， 凸）
     */
    
    public static func printCrease(curLevel: Int, level: Int, down: Bool){
        if curLevel > level { return }
        printCrease(curLevel: curLevel + 1, level: level, down: true)
        print(down ? "凹" : "凸")
        printCrease(curLevel: curLevel + 1, level: level, down: false)
    }
    /**
     树形DP
     */
}

