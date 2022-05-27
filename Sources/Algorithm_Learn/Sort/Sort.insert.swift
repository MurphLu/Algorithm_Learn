//
//  File.swift
//  
//
//  Created by Murph on 2022/5/25.
//

import Foundation

extension Sort {
    /**
     遍历比较为 1 + 2 + 3 .....N-2 + N-1 + N 次，次数不定，最差情况为此
     最终时间复杂度 aN^2 + bN + C，最终时间复杂度 O(N^2)
     */
    public static func insertSort<T: Comparable>(arr: inout Array<T>) {
        for idx in 1..<arr.count {
            let temp = arr[idx]
            var i = idx
            while (i > 0) && (temp < arr[i-1]) {
                arr[i] = arr[i-1]
                i -= 1
            }
            arr[i] = temp
        }
    }
}
