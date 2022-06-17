//
//  File.swift
//  
//
//  Created by Murph on 2022/6/6.
//

import Foundation

extension Question {
    /**
     基本有序的一个大数组（升序），若使数组有序，需要调整的数移动步数最多不超过 K，且 K 很小
     */
    public static func sort(){
        var arr = [Int]()
        var heapSize = 0
        for i in 1..<100 {
            if i % 10 == 3 { arr.append(i / 10 * 10 + 9) }
            else if i % 10 == 9 { arr.append(i / 10 * 10 + 3) }
            else {arr.append(i)}
        }
        var temp = [Int]()
        for i in 0...7 {
            temp.append(arr[i])
            heapInsert(arr: &temp, index: i)
            heapSize += 1
        }
        var num = 8
        while heapSize > 0 {
            if temp[0] > 93 {
                print(111)
            }
            print(temp[0])
            temp[0] = temp[heapSize - 1]
            heapSize -= 1
            heapify(arr: &temp, index: 0, size: heapSize)
            if num < 99 {
                temp[heapSize] = arr[num]
                heapInsert(arr: &temp, index: heapSize - 1)
                heapSize += 1
                num += 1
            }
        }
    }
    
    public static func heapInsert(arr: inout [Int], index: Int) {
        var temp = index
        while arr[temp] < arr[(temp - 1) / 2] {
            arr.changeValue(index1: temp, index2: (temp - 1) / 2)
            temp = (temp - 1) / 2
        }
    }
    
    public static func heapify(arr: inout [Int], index: Int, size: Int) {
        var temp = index
        var left = temp * 2 + 1
        while left < size {
            let right = left + 1
            var minIndex = (right < size) && (arr[left] > arr[right]) ? right : left
            minIndex = arr[temp] > arr[minIndex] ? minIndex : temp
            if minIndex == temp { break }
            arr.changeValue(index1: temp, index2: minIndex)
            temp = minIndex
            left = temp * 2 + 1
        }
    }
}
