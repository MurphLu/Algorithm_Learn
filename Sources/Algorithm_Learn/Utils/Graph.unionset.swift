//
//  Graph.unionset.swift
//  
//
//  Created by Murph on 2022/8/31.
//

import Foundation

class SetMapValue: Equatable {
    
    var arr = Array<GNode>()
    
    var address_: String {
        let opaque = Unmanaged.passUnretained(self).toOpaque()
        let addressVal = String(describing: opaque)
        return addressVal
    }
    
    static func == (lhs: SetMapValue, rhs: SetMapValue) -> Bool {
        return lhs.address_ == rhs.address_
    }
}

class UnionSet {
    var setMap = [GNode: SetMapValue]()
    
    func mySet(nodes: Array<GNode>) {
        for node in nodes {
            var set = SetMapValue()
            set.arr.append(node)
            setMap[node] = set
        }
    }
    
    public func isSameSet(fromNode: GNode, toNode: GNode) -> Bool {
        let fromSet = setMap[fromNode]
        let toSet = setMap[toNode]
        return fromSet == toSet
    }
    
    public func union(fromNode: GNode, toNode: GNode) {
        var fromSet = setMap[fromNode]!
        let toSet = setMap[toNode]!
        for node in toSet.arr {
            fromSet.arr.append(node)
            setMap[toNode] = fromSet
        }
    }
}

