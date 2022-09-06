//
//  File.swift
//  
//
//  Created by Murph on 2022/5/23.
//

import Foundation

extension Sort {
    /**
     遍历 N + N-1 + N-2 + N-3 ...... 1 次，比较也是一样多次
     交换 N
     最终时间复杂度 aN^2 + bN + C，最终时间复杂度 O(N^2)
     */
    public static func selectionSort<T: Comparable>( arr: inout Array<T>) {
        let count = arr.count
        if count < 2 { return }
        for i in 0..<count {
            var minIndex = i
            for j in (i+1)..<count {
                minIndex = arr[minIndex] > arr[j] ? j : minIndex
            }
            if minIndex != i { arr.swap(i, minIndex) }
        }
    }
}
