//
//  File.swift
//  
//
//  Created by Murph on 2022/9/1.
//

import Foundation

extension Algorithm {
    /// 最小生成树  无向图  k算法  边
    public static func krusalMST(graph: Graph) -> Set<Edge>{
        let unionSet = UnionSet();
        unionSet.mySet(nodes: Array(graph.nodes.values))
        var edges = Array<Edge>();
        for edge in graph.edges {
            edges.append(edge)
        }
        
        edges.sort(by: { $0.weight > $1.weight })
        
        var result = Set<Edge>()
        while(!edges.isEmpty) {
            let edge = edges.popLast()!
            if !unionSet.isSameSet(fromNode: edge.from, toNode: edge.to) {
                result.insert(edge)
                unionSet.union(fromNode: edge.from, toNode: edge.to)
            }
        }
        return result
    }
}
