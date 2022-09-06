//
//  File.swift
//  
//
//  Created by Murph on 2022/9/1.
//

import Foundation

extension Algorithm {
    /// 最小生成树  无向图  p算法 点
    /// 如果考虑多个不相连的树，那么在顶层需要加上遍历图中node的方法
    public static func primMST(graph: Graph) -> Set<Edge> {
        let node = graph.nodes.values.first!
        let queue = PriorityQueue<Edge>(list: [Edge]()) { o1, o2 in
            o1.weight < o2.weight
        }
        var nodeSet = Set<GNode>()
        var result = Set<Edge>()
        
        nodeSet.insert(node)
        
        for edge in node.edge {
            queue.push(edge)
        }
        
        while !queue.isEmpty() {
            let edge = queue.pop()!
            print(edge.weight)
            if !nodeSet.contains(edge.to) {
                nodeSet.insert(edge.to)
                result.insert(edge)
                for _edge in edge.to.edge {
                    queue.push(_edge)
                }
            }
        }
        
        return result
    }
}
