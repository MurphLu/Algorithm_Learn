//
//  Question.addMins.swift
//  
//
//  Created by Murph on 2022/5/27.
//

import Foundation

extension Question {
    /**
     小和问题
     计算数组中每个元素之前的所有小于该元素数据的和，并返回总和
     [1,3,4,2,5]
     1 前所有小于该元素的和为 0
     3 前所有小于该元素的和为 1
     4 前所有小于该元素的和为 4
     2 前所有小于该元素的和为 1
     5 前所有小于该元素的和为 10
     最终输出16
     */
    public static var targetAddMin = 0
    
    public static func addMins(arr: Array<Int>) {
        targetAddMin = 0
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
                targetAddMin += arr1[index1] * (arr2.count - index2)
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
