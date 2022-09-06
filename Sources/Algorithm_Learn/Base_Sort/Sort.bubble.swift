//
//  File.swift
//  
//
//  Created by Murph on 2022/5/23.
//

import Foundation

extension Sort {
    /**
     遍历比较为 N + N-1 + N-2 + N-3 ...... 1 次，交换可能次数不定
     最终时间复杂度 aN^2 + bN + C，最终时间复杂度 O(N^2)
     */
    static func bubbleSort<T:Comparable>(arr: inout Array<T>) {
        let count = arr.count
        if count < 2 { return }
        for i in 0..<count {
            for j in 0..<count-i-1 {
                if arr[j] > arr[j+1] {
                    arr.swap(j, j+1)
                }
            }
        }
    }

}
