//
//  File.swift
//  
//
//  Created by Murph on 2022/6/6.
//

import Foundation

extension Sort {
    /**
     时间复杂度 O(N*logN)
     空间复杂度 O(1)
     */
    public static func heapSort<T: Comparable>(arr: inout [T]) {
        if arr.count < 2 { return }
        for i in 0..<arr.count { // O(N)
            heapInsert(arr: &arr, index: i) //O(logN)
        }
        
        var heapSize = arr.count - 1
        arr.changeValue(index1: 0, index2: heapSize)
        while heapSize > 0 { // O(N)
            heapify(arr: &arr, index: 0, heapSize: heapSize) // O(logN)
            heapSize -= 1
            arr.changeValue(index1: 0, index2: heapSize)
        }
    }
    
    private static func heapInsert<T: Comparable>(arr: inout [T], index: Int) {
        var temp = index
        while arr[temp] > arr[(temp-1) / 2] {
            arr.changeValue(index1: temp, index2: (temp-1) / 2)
            temp = (temp - 1) / 2
        }
    }
    
    private static func heapify<T: Comparable>(arr: inout [T], index: Int, heapSize: Int) {
        var innerIndex = index
        var left = innerIndex * 2 + 1
        while left < heapSize {
            var largest = (left + 1) < heapSize && (arr[left + 1] > arr[left]) ? left
            + 1 : left
            largest = arr[innerIndex] < arr[largest] ? largest : innerIndex
            if largest == innerIndex { break }
            arr.changeValue(index1: largest, index2: innerIndex)
            innerIndex = largest
            left = innerIndex * 2 + 1
        }
    }
}
