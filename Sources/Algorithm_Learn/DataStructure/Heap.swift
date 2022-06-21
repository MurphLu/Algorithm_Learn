//
//  File.swift
//  
//
//  Created by Murph on 2022/6/6.
//

import Foundation
// 大根堆
class Heap<T: Comparable> {
    private var list: [T]
    private var size: Int = 0
    public init(list: [T]) {
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
        while list[temp] > list[(temp-1) / 2] {
            list.changeValue(index1: temp, index2: (temp-1) / 2)
            temp = (temp - 1) / 2
        }
    }
    
    private func heapify(index: Int, heapSize: Int) {
        var innerIndex = index
        var left = innerIndex * 2 + 1
        while left < heapSize {
            var largest = (left + 1) < heapSize && (list[left + 1] > list[left]) ? left
            + 1 : left
            largest = list[innerIndex] < list[largest] ? largest : innerIndex
            if largest == innerIndex { break }
            list.changeValue(index1: largest, index2: innerIndex)
            innerIndex = largest
            left = innerIndex * 2 + 1
        }
    }
}
