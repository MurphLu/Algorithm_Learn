//
//  Sort.quick.swift
//  
//
//  Created by Murph on 2022/6/2.
//

import Foundation

extension Sort {
    /**
     如果不通过随机取值来作为比较用值，那么快排的时间复杂度为 O(logN) - O(N^2)
     随机取值后，由于概率加入进来，那么，最终的时间复杂度为 O(N * logN)
     */
    public static func quickSort<T: Comparable>(arr: inout Array<T>) {
        process(arr: &arr, left: 0, right: arr.count - 1)
    }
    
    private static func process<T: Comparable>(arr: inout Array<T>, left: Int, right: Int) {
        if left < right {
            arr.changeValue(index1: Int.random(in: left...right), index2: right)
            let partation = partation(arr: &arr, left: left, right: right)
            process(arr: &arr, left: left, right: partation.0 - 1)
            process(arr: &arr, left: partation.1 + 1, right: right)
        }
    }
    
    private static func partation<T: Comparable>(arr: inout Array<T>, left: Int, right: Int) -> (Int, Int) {
        var tempLeft = left
        
        var less = left - 1
        var more = right
        while tempLeft < more {
            if arr[tempLeft] < arr[right] {
                less += 1
                arr.changeValue(index1: less, index2: tempLeft)
                tempLeft += 1
            } else if arr[tempLeft] > arr[right] {
                more -= 1
                arr.changeValue(index1: tempLeft, index2: more)
            } else {
                tempLeft += 1
            }
        }
        arr.changeValue(index1: more, index2: right)
        
        
        return (less + 1, more)
    }
}
