//
//  File.swift
//  
//
//  Created by Murph on 2022/9/1.
//

import Foundation

extension Algorithm {
    ///Di jkstra 算法，没有权值为负的边
    /// 从一个点出发，计算从该点到所有点的路径最小值
    public static func DIJkstra(head: GNode) -> [GNode: Int] {
        var distanceMap = [GNode: Int]()
        var lockedSet = Set<GNode>()
        var result = [GNode: Int]()
        
        func getMinDistanceNoLock() -> (key: GNode, value: Int)? {
            let min = distanceMap.min(by: { $0.value < $1.value} )
            return min
        }
        
        distanceMap[head] = 0;
        for edge in head.edge {
            distanceMap.removeValue(forKey: edge.to)
        }
        
        result[head] = distanceMap[head]
        distanceMap[head] = 0
        while !distanceMap.isEmpty {
            let min = getMinDistanceNoLock()!
            let curNode = min.key
            let curDistance = min.value
            
            for edge in curNode.edge {
                let toNode = edge.to
                if !lockedSet.contains(toNode) {
                    let newDistance = curDistance + edge.weight
                    if let distance = distanceMap[toNode], distance < newDistance {} else {
                        distanceMap[toNode] = newDistance
                    }
                }
            }
            result[min.key] = min.value
            lockedSet.insert(min.key)
            distanceMap.removeValue(forKey: min.key)
        }
        return result
    }
}
