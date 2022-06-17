//
//  Sort.bucket.swift
//  
//
//  Created by Murph on 2022/6/16.
//

import Foundation

extension Sort {
    public static func bucketSort(arr: inout [Int]) {
        if arr.count <= 1 { return }
        let result = process(arr: arr, start: 0, end: arr.count)
        for i in 0..<result.count {
            arr[i] = result[i]
        }
    }
    
    private static func process(arr: [Int], start: Int, end: Int) -> [Int]{
        let digit = getMaxDigist(arr: arr, start: start, end: end)
        var temp = arr
        for i in 1...digit {
            var bucket = Array.init(repeating: 0, count: arr.count)
            var count = Array.init(repeating: 0, count: 10)
            for index in start...end {
                let currentDigistNum = getDigist(num: temp[index], at: i)
                count[currentDigistNum] = count[currentDigistNum] + 1
            }
            for countIndex in 1..<10 {
                count[countIndex] = count[countIndex] + count[countIndex - 1]
            }
            var bucketIndex = bucket.count - 1
            while bucketIndex >= 0 {
                let current = temp[bucketIndex]
                let currentDigistNum = getDigist(num: current, at: i)
                bucket[count[currentDigistNum] - 1] = current
                count[currentDigistNum]  = count[currentDigistNum] - 1
                bucketIndex -= 1
            }
            temp = bucket
        }
        return temp
    }
    
    private static func getMaxDigist(arr: [Int], start: Int, end: Int) -> Int {
        var maxValue = arr[start...end].max()!
        var maxDigist = 0
        while maxValue > 0 {
            maxValue /= 10
            maxDigist += 1
        }
        return maxDigist
    }
    
    private static func getDigist(num: Int, at position: Int) -> Int{
        if position == 1 { return num % 10 }
        return num / 10^(position - 1) % 10
    }
}
