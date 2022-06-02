//
//  Question.reversePair.swift
//
//
//  Created by Murph on 2022/5/27.
//

import Foundation

extension Question {
    /**
     逆序
     一个数与自己右侧比自己大的数构成逆序对，请打印所有逆序对
     */
    public static var targetReversePair = [(Int,Int)]()
    
    public static func reversePair(arr: Array<Int>) {
        targetReversePair.removeAll()
        let _ = process(arr: arr, left: 0, right: arr.count - 1)
    }
    
    private static func process(arr: [Int], left: Int, right: Int) -> [Int]{
        if left == right { return [arr[left]] }
        let middle = left + (right - right) >> 2
        let arr1 = process(arr: arr, left: left, right: middle)
        let arr2 = process(arr: arr, left: middle + 1, right: right)
        return merge(arr1: arr1, arr2: arr2)
    }
    
    private static func merge(arr1: [Int], arr2: [Int]) -> [Int] {
        var index1 = 0
        var index2 = 0
        var result = [Int]()
        while index1 < arr1.count && index2 < arr2.count {
            if arr1[index1] < arr2[index2] {
                result.append(arr1[index1])
                index1 += 1
                continue
            } else {
                result.append(arr2[index2])
                if arr1[index1] > arr2[index2] { targetReversePair.append((arr1[index1], arr2[index2])) }
                index2 += 1
                continue
            }
        }
        if index1 < arr1.count { result.append(contentsOf: arr1[index1..<arr1.count]) }
        if index2 < arr2.count { result.append(contentsOf: arr2[index2..<arr2.count]) }
        return result
    }
}
