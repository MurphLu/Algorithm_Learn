//
//  Graph.swift
//  
//
//  Created by Murph on 2022/7/4.
//

import Foundation

class GNode: Hashable {
    var value: Int
    var `in`: Int
    var out: Int
    var nexts: [GNode]
    var edge: [Edge]
    
    init(_ val: Int) {
        self.value = val
        self.in = 0
        self.out = 0
        self.nexts = [GNode]()
        self.edge = [Edge]()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.address_)
    }
    
    var address_: String {
        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let addressVal = String(describing: opaque)
        return addressVal
    }
    
    static func == (lhs: GNode, rhs: GNode) -> Bool {
        return lhs.address_ == rhs.address_
    }
}

class Edge: Hashable{
    static func == (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.address_ == rhs.address_
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.weight)
        hasher.combine(self.address_)
    }
    
    var address_: String {
        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let addressVal = String(describing: opaque)
        return addressVal
    }
    
    var weight: Int
    var from: GNode
    var to: GNode
    
    init(weight: Int, from: GNode, to: GNode) {
        self.weight = weight
        self.from = from
        self.to = to
    }
}

class Graph {
    var nodes: [Int: GNode]
    var edges: Set<Edge>
    
    init(){
        self.nodes = [Int: GNode]()
        self.edges = Set<Edge>()
    }
}

typealias MatrixTuple = (from: Int, to: Int, weight: Int)

class GraphBase {
    /**
     N*3 的矩阵
     [weight, from 节点上的值，to 节点上的值]
     */
    public static func createGraph(matrix: [[Int]]) -> Graph {
        let graph = Graph()
        for ele in matrix {
            let weight = ele[0]
            let from = ele[1]
            let to = ele[2]
            if graph.nodes[from] == nil {
                graph.nodes[from] = GNode(from)
            }
            if graph.nodes[to] == nil {
                graph.nodes[to] = GNode(to)
            }
            
            let fromNode = graph.nodes[from]!
            let toNode = graph.nodes[to]!
            let edge = Edge(weight: weight, from: fromNode, to: toNode)
            fromNode.nexts.append(toNode)
            fromNode.out += 1
            toNode.in += 1
            
            fromNode.edge.append(edge)
            graph.edges.insert(edge)
        }
        return graph
    }
    
    public static func createGraph(matrixes: [MatrixTuple], directed: Bool) -> Graph {
        let graph = Graph()
        
        for ele in matrixes {
            let weight = ele.weight
            let from = ele.from
            let to = ele.to
            
            let fromNode = graph.nodes[from] ?? GNode(from)
            let toNode = graph.nodes[to] ?? GNode(to)
            graph.nodes[from] = fromNode
            graph.nodes[to] = toNode
            
            let edge = Edge(weight: weight, from: fromNode, to: toNode)
            
            fromNode.nexts.append(toNode)
            fromNode.out += 1
            toNode.in += 1
            fromNode.edge.append(edge)
            graph.edges.insert(edge)
            
            if !directed {
                let edgeReverse = Edge(weight: weight, from: toNode, to: fromNode)
                toNode.nexts.append(fromNode)
                toNode.out += 1
                fromNode.in += 1
                toNode.edge.append(edgeReverse)
                graph.edges.insert(edgeReverse)
            }
            
        }
        return graph
    }
    
    /**
     图的宽度优先遍历
     */
    public static func bfs(_ node: GNode?) {
        guard let root = node else { return }
        let queue = Queue<GNode>()
        var set = Set<GNode>()
        queue.input(root)
        set.insert(root)
        while let node = queue.output() {
            print(node.value)
            for next in node.nexts {
                if !set.contains(next) {
                    queue.input(next)
                    set.insert(next)
                }
            }
        }
    }
    
    /**
     图的深度优先遍历
     */
    public static func dfs(_ root: GNode?) {
        guard let root = root else { return }
        var arr = [GNode]()
        arr.append(root)
        var set = Set<GNode>()
        print(root.value)
        while let node = arr.popLast() {
            for next in node.nexts {
                if !set.contains(next) {
                    arr.append(node)
                    arr.append(next)
                    set.insert(next)
                    print(next)
                }
            }
        }
    }
    
    /**
     拓扑排序
     适用范围，有向图，有入度为0的节点，且无环
     */
    
    public static func sortedTopology(_ graph: Graph) -> [GNode] {
        var result = [GNode]()
        var inDic = [GNode: Int]()
        let zeroQueue = Queue<GNode>()
        
        for node in graph.nodes.values {
            inDic[node] = node.in
            if node.in == 0 {
                zeroQueue.input(node)
            }
        }
        while let node = zeroQueue.output() {
            result.append(node)
            for next in node.nexts {
                inDic[next] = inDic[next]! - 1
                if inDic[next] == 0 {
                    zeroQueue.input(next)
                }
            }
        }
        return result
    }
}
