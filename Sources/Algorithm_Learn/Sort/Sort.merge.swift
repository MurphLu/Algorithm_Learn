//
//  File.swift
//  
//
//  Created by Murph on 2022/5/27.
//

import Foundation

extension Sort {
    /**
     时间复杂度 O(N*logN)
     空间复杂度 O(N)
     */
    public static func mergeSort<T: Comparable>(arr: inout Array<T>) {
        let result = process(arr: arr, left: 0, right: arr.count - 1)
        
        for i in 0..<result.count {
            arr[i] = result[i]
        }
    }
    
    private static func process<T: Comparable>(arr: Array<T>, left: Int, right: Int) -> [T]{
        if left == right { return [arr[left]] }
        let middle = left + (right - right) >> 2
        let arr1 = process(arr: arr, left: left, right: middle)
        let arr2 = process(arr: arr, left: middle + 1, right: right)
        return merge(arr1: arr1, arr2: arr2)
    }
    
    private static func merge<T: Comparable>(arr1: Array<T>, arr2: Array<T>) -> [T] {
        var index1 = 0
        var index2 = 0
        var result = [T]()
        while index1 < arr1.count && index2 < arr2.count {
            if arr1[index1] < arr2[index2] {
                result.append(arr1[index1])
                index1 += 1
                continue
            } else {
                result.append(arr2[index2])
                index2 += 1
                continue
            }
        }
        if index1 < arr1.count { result.append(contentsOf: arr1[index1..<arr1.count]) }
        if index2 < arr2.count { result.append(contentsOf: arr2[index2..<arr2.count]) }
        return result
    }
}
