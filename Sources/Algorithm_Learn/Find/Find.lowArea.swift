//
//  File.swift
//  
//
//  Created by Murph on 2022/5/26.
//

import Foundation

extension Find {
    /**
     局部最小
     一个无序数组，相邻两个数必不相等，找到该数组中任意最小区域
     如果 `arr[0] < arr[1]` 那么 `index = 0` 为最小区域
     如果 `arr[arr.count - 1 ] < arr[arr.count - 2]` 那么 `index = arr.count - 1` 为最小区域
     其他情况则必须满足 `arr[index - 1] > arr[index] < arr[index + 1]`
     时间复杂度小于 O(N)
     二分查找
     */
    public static func findLowArea(arr: Array<Int>) -> Int {
        if arr[0] < arr[1] { return 0 }
        if arr[arr.count - 1] < arr[arr.count - 2] { return arr[arr.count - 1] }
        return findLowArea(arr: arr, left: 0, right: arr.count - 1)
    }
    
    private static func findLowArea(arr: Array<Int>, left: Int, right: Int) -> Int {
        // 防止数组长度过大的时候溢出
        let middle = left + (right - left) >> 2
        if arr[middle] > arr[middle - 1] {
            return findLowArea(arr: arr, left: left, right: middle)
        }
        if arr[middle] > arr[middle + 1] {
            return findLowArea(arr: arr, left: middle, right: right)
        }
        return middle
    }
}
