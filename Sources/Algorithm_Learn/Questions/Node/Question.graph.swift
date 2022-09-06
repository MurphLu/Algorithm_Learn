//
//  Question.graph.swift
//  
//
//  Created by Murph on 2022/7/5.
//

import Foundation

extension Question {
    public static func createGraph(n: Int, edges: [[Int]], singlePath: Bool) -> Graph {
        var nodes = [Int: GNode]()
        for i in 0..<n {
            nodes[i] = GNode(i)
        }
        var edgeSet = Set<Edge>()
        for val in edges {
            let from = nodes[val[0]]!
            let to = nodes[val[1]]!
            from.nexts.append(to)
            from.out += 1
            to.in += 1
            let edge = Edge(weight: val.count == 3 ? val[2] : 1, from: from, to: to)
            from.edge.append(edge)
            edgeSet.insert(edge)
            if !singlePath {
                to.nexts.append(from)
                to.out += 1
                from.in += 1
                let edge2 = Edge(weight: val.count == 3 ? val[2] : 1, from: to, to: from)
                to.edge.append(edge2)
                edgeSet.insert(edge2)
            }
        }
        
        let graph = Graph()
        graph.nodes = nodes
        graph.edges = edgeSet
        return graph
    }
    
    /**
     给你一棵由 n 个顶点组成的无向树，顶点编号从 1 到 n。青蛙从 顶点 1 开始起跳。规则如下：

     在一秒内，青蛙从它所在的当前顶点跳到另一个 未访问 过的顶点（如果它们直接相连）。
     青蛙无法跳回已经访问过的顶点。
     如果青蛙可以跳到多个不同顶点，那么它跳到其中任意一个顶点上的机率都相同。
     如果青蛙不能跳到任何未访问过的顶点上，那么它每次跳跃都会停留在原地。
     无向树的边用数组 edges 描述，其中 edges[i] = [fromi, toi] 意味着存在一条直接连通 fromi 和 toi 两个顶点的边。

     返回青蛙在 t 秒后位于目标顶点 target 上的概率。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/frog-position-after-t-seconds
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    public static func frogProsition(n: Int, edges: [[Int]], t: Int, target: Int) -> Double {
        struct ResultPath{
            var path: [GNode] = [GNode]()
            var possiblity: Double = 1
            
            init(path: [GNode], possiblity: Double) {
                self.path = path
                self.possiblity = possiblity
            }
        }
        
        let graph = createGraph(n: n, edges: edges, singlePath: false)
        
        var resultArr = [ResultPath]()
        var tempT = t
        resultArr.append(ResultPath(path: [graph.nodes[1]!], possiblity: 1))
        while tempT > 0 {
            var tempResultArr = [ResultPath]()
            while let result = resultArr.popLast() {
                guard let nexts = result.path.last?.nexts, !nexts.isEmpty else {
                    tempResultArr.append(result)
                    continue
                }
                var canJumpNext = [GNode]()
                for next in nexts {
                    if !result.path.contains(next) {
                        canJumpNext.append(next)
                    }
                }
                if canJumpNext.isEmpty {
                    tempResultArr.append(result)
                    continue
                }
                for node in canJumpNext {
                    var temp = result
                    temp.path.append(node)
                    temp.possiblity = result.possiblity * (1 / Double(canJumpNext.count))
                    tempResultArr.append(temp)
                }
            }
            resultArr = tempResultArr
            tempT -= 1
        }
        
        var result: Double = 0
        for resultPath in resultArr {
            if resultPath.path.last?.value == target { result += resultPath.possiblity }
        }
        return result
    }
    
    /**
     小镇里有 n 个人，按从 1 到 n 的顺序编号。传言称，这些人中有一个暗地里是小镇法官。

     如果小镇法官真的存在，那么：

     小镇法官不会信任任何人。
     每个人（除了小镇法官）都信任这位小镇法官。
     只有一个人同时满足属性 1 和属性 2 。
     给你一个数组 trust ，其中 trust[i] = [ai, bi] 表示编号为 ai 的人信任编号为 bi 的人。

     如果小镇法官存在并且可以确定他的身份，请返回该法官的编号；否则，返回 -1 。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/find-the-town-judge
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    public static func findJudge(_ n: Int, _ trust: [[Int]]) -> Int {
        let graph = createGraph(n: n, edges: trust, singlePath: true)
        let nodeList = graph.nodes.values
        var result = -1
        for node in nodeList {
            if node.in == nodeList.count - 1 && node.out == 0{
                result = node.value
            }
        }
        return result
    }
    
    /**
     有 n 个城市通过一些航班连接。给你一个数组 flights ，其中 flights[i] = [fromi, toi, pricei] ，表示该航班都从城市 fromi 开始，以价格 pricei 抵达 toi。

     现在给定所有的城市和航班，以及出发城市 src 和目的地 dst，你的任务是找到出一条最多经过 k 站中转的路线，使得从 src 到 dst 的 价格最便宜 ，并返回该价格。 如果不存在这样的路线，则输出 -1。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/cheapest-flights-within-k-stops
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    public static func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {
        struct PathPrice {
            var path: Set<GNode>
            var last: GNode
            var price: Int
             
            init(path: Set<GNode>, last: GNode, price: Int){
                self.path = path
                self.price = price
                self.last = last
            }
        }
        let graph = createGraph(n: n, edges: flights, singlePath: true)
        var pathList = [PathPrice]()
        let nodeMap = graph.nodes
        pathList.append(PathPrice(path: [nodeMap[src]!], last: nodeMap[src]!,  price: 0))
        var stationCount = k + 1
        var minVal: Int?
        var toNodeMinPrice = [GNode: Int]()
        while stationCount > 0 {
            var tempPath = [PathPrice]()
            while let pathPrice = pathList.popLast() {
                if pathPrice.last.value != dst {
                    for path in pathPrice.last.edge {
                        if pathPrice.path.contains(path.to){ continue }
                        var temp = pathPrice
                        temp.path.insert(path.to)
                        temp.last = path.to
                        temp.price += path.weight
                        if (minVal != nil && minVal! < temp.price) { continue }
                        if let price = toNodeMinPrice[path.to] {
                            if price > temp.price {
                                toNodeMinPrice[path.to] = temp.price
                                tempPath.append(temp)
                            }
                        } else {
                            toNodeMinPrice[path.to] = temp.price
                            tempPath.append(temp)
                        }
                    }
                } else {
                    if (minVal != nil && minVal! < pathPrice.price) { continue }
                    tempPath.append(pathPrice)
                    minVal = minVal == nil ? pathPrice.price : min(pathPrice.price, minVal!)
                }
            }
            pathList = tempPath
            stationCount -= 1
        }
        
        pathList.sort(by: {$0.price < $1.price})
        for path in pathList {
            if path.last.value == dst {
                return path.price
            }
        }
        return -1
    }
    
    /**
    你这个学期必须选修 numCourses 门课程，记为 0 到 numCourses - 1 。

    在选修某些课程之前需要一些先修课程。 先修课程按数组 prerequisites 给出，其中 prerequisites[i] = [ai, bi] ，表示如果要学习课程 ai 则 必须 先学习课程  bi 。

    例如，先修课程对 [0, 1] 表示：想要学习课程 0 ，你需要先完成课程 1 。
    请你判断是否可能完成所有课程的学习？如果可以，返回 true ；否则，返回 false 。



    来源：力扣（LeetCode）
    链接：https://leetcode.cn/problems/course-schedule
    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    public static func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        let requires = prerequisites.map({ Array($0.reversed()) })
        var resultList = [GNode]()
        let graph = createGraph(n: numCourses, edges: requires, singlePath: true)
        var inZeroQueue = [GNode]()
        var inMap = [GNode: Int]()
        for node in graph.nodes.values {
            inMap[node] = node.in
            if node.in == 0 {
                inZeroQueue.append(node)
            }
        }
        
        while let node = inZeroQueue.popLast() {
            resultList.append(node)
            for next in node.nexts {
                inMap[next] = inMap[next]! - 1
                if inMap[next] == 0 {
                    inZeroQueue.append(next)
                }
            }
        }
        if resultList.count == numCourses {
            return true
        }
        return false
    }
    
    /**
     树是一个无向图，其中任何两个顶点只通过一条路径连接。 换句话说，一个任何没有简单环路的连通图都是一棵树。

     给你一棵包含 n 个节点的树，标记为 0 到 n - 1 。给定数字 n 和一个有 n - 1 条无向边的 edges 列表（每一个边都是一对标签），其中 edges[i] = [ai, bi] 表示树中节点 ai 和 bi 之间存在一条无向边。

     可选择树中任何一个节点作为根。当选择节点 x 作为根节点时，设结果树的高度为 h 。在所有可能的树中，具有最小高度的树（即，min(h)）被称为 最小高度树 。

     请你找到所有的 最小高度树 并按 任意顺序 返回它们的根节点标签列表。

     树的 高度 是指根节点和叶子节点之间最长向下路径上边的数量。

     来源：力扣（LeetCode）
     链接：https://leetcode.cn/problems/minimum-height-trees
     著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
     */
    
    static func findMinHeightTrees(_ n: Int, _ edges: [[Int]]) -> [Int] {
        let graph = createGraph(n: n, edges: edges, singlePath: false)
        var result = [Int]()
        var minHeight = 0
        var nodeList = Array(graph.nodes.values).sorted(by: {$0.nexts.count > $1.nexts.count})
        if nodeList.count > 2 { nodeList = nodeList.filter({ $0.nexts.count > 1})}
        for value in nodeList {
            let queue = Queue<(node: GNode, level: Int)>()
            queue.input((value, 0))
            var currHeight = 0
            var nodeSet = Set<GNode>()
            nodeSet.insert(value)
            while let nodeLevel = queue.output() {
                currHeight = max(nodeLevel.level, currHeight)
                var needBreak = false
                for node in nodeLevel.node.nexts {
                    
                    if nodeSet.contains(node) { continue }
                    if minHeight != 0 && minHeight == currHeight {
                        currHeight = currHeight + 1
                        needBreak = true
                        break
                    }
                    nodeSet.insert(node)
                    if node.nexts.count == 1 { continue }
                    queue.input((node, nodeLevel.level + 1))
                }
                if needBreak { break }
            }
            currHeight += 1
            if minHeight == 0 {
                minHeight = currHeight
                result.append(value.value)
            } else if minHeight < currHeight {
                continue
            } else if minHeight > currHeight {
                result.removeAll()
                result.append(value.value)
                minHeight = currHeight
            } else if minHeight == currHeight {
                result.append(value.value)
            }
        }
        return result
    }
    
    static func findMinHeightTrees2(_ n: Int, _ edges: [[Int]]) -> [Int] {
        let graph = createGraph(n: n, edges: edges, singlePath: false)
        var inMap = [GNode: Int]()
        for node in graph.nodes.values {
            inMap[node] = node.in
        }
        while true {
            if !inMap.contains(where: {$0.value > 1}) {
                break
            }
            let nodeToDel = inMap.filter({$0.value == 1}).keys
            for node in nodeToDel {
                inMap.removeValue(forKey: node)
                for to in node.nexts {
                    if let val = inMap[to] {
                        inMap[to] = val - 1
                    }
                }
            }
        }
        return inMap.keys.map({$0.value})
    }
    
    
    
    
    
    
}
