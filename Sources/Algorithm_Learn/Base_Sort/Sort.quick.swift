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
//        if(left - right < 60) {
//            在arr[l..r] 插入排序
//            O(N^2) 小样本量的时候跑的快
//        }
        if left < right {
            arr.changeValue(index1: Int.random(in: left...right), index2: right)
            let partation = partation(arr: &arr, left: left, right: right)
            process(arr: &arr, left: left, right: partation.0)
            process(arr: &arr, left: partation.1, right: right)
        }
    }
    
    private static func partation<T: Comparable>(arr: inout Array<T>, left: Int, right: Int) -> (Int, Int) {
        var index = left
        
        var less = left - 1
        var more = right
        while index < more {
            if arr[index] < arr[right] {
                // 将小于参考值的当前索引值与小边界下一位做交换，
                // 由于小值多了一个，所以并将小边界右移一位
                less += 1
                arr.changeValue(index1: less, index2: index)
                // 由于交换完之后 index 及之前的值都小于等于参考值，所以将 index + 1 继续对比
                index += 1
            } else if arr[index] > arr[right] {
                // 如果当前值大于参考值，则将当前值与有边界前一位交换，大边界左移一位
                // 由于交换完之后 当前 index 的值已经变为未做过比较的值，所以 index 不动，继续对比
                more -= 1
                arr.changeValue(index1: index, index2: more)
            } else {
                // 当前值等于参考值，那么 index + 1 继续对比下一位
                index += 1
            }
        }
        
        // 由于 right 位置为参考值，more 为大边界，more 之前的值都 <= 参考值，所以将 more 与 right 交换，
        arr.changeValue(index1: more, index2: right)
        return (less, more + 1)
    }
}
