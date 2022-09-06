//
//  File.swift
//  
//
//  Created by Murph on 2022/8/31.
//

import Foundation

class PriorityQueue<T> {
    private let comparator: (_ o1: T, _ o2: T) -> Bool
    private var list: [T]
    private var size: Int = 0
    
    public func isEmpty() -> Bool{
        return size == 0
    }
    
    public init(list: [T], comparator: @escaping (_ o1: T, _ o2: T) -> Bool) {
        self.comparator = comparator
        self.list = list
        build()
    }
    
    public func push(_ val: T) {
        list.append(val)
        size += 1
        heapInsert(index: size - 1)
    }
    
    public func pop() -> T? {
        if size == 0 {
            return nil
        }
        let val = list.first
        list.changeValue(index1: 0, index2: size - 1)
        size -= 1
        heapify(index: 0, heapSize: size)
        return val
    }
    
    private func build() {
        if list.count < 2 { return }
        size = list.count
        var i = list.count - 1
        while i >= 0 {
            heapify(index: i, heapSize: size)
            i -= 1
        }
    }
    
    private func heapInsert(index: Int) {
        var temp = index
        while comparator(list[temp], list[(temp-1) / 2]) {
            list.changeValue(index1: temp, index2: (temp-1) / 2)
            temp = (temp - 1) / 2
        }
    }
    
    private func heapify(index: Int, heapSize: Int) {
        var innerIndex = index
        var left = innerIndex * 2 + 1
        while left < heapSize {
            var target = (left + 1) < heapSize && (comparator(list[left + 1], list[left])) ? left
            + 1 : left
            target = comparator(list[innerIndex], list[target]) ? innerIndex : target
            if target == innerIndex { break }
            list.changeValue(index1: target, index2: innerIndex)
            innerIndex = target
            left = innerIndex * 2 + 1
        }
    }
}
