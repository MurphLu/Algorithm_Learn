//
//  File.swift
//  
//
//  Created by Murph on 2022/4/26.
//

import Foundation

extension Array {
    mutating func changeValue(index1: Int, index2: Int){
        let temp = self[index1]
        self[index1] = self[index2]
        self[index2] = temp
    }
}

class SortT {
    // MARK: 插入排序
    static func insertSort<T: Comparable>(list: inout Array<T>) {
        for index in 1..<list.count {
            let temp = list[index]
            var position = index
            while position > 0 && temp < list[position - 1] {
                list[position] = list[position - 1]
                position -= 1
            }
            list[position] = temp
        }
    }
    
    
    // MARK: 冒泡排序
    static func bubbleSort<T:Comparable>(list: inout Array<T>) {
        var temp: T
        for idx in 0..<list.count {
            let i = list.count - 1 - idx
            for j in 0..<i {
                if list[j] > list[j+1] {
                    temp = list[j]
                    list[j] = list[j+1]
                    list[j+1] = temp
                }
            }
        }
    }
    
    // MARK: 快速排序
    static func quickSort<T: Comparable>(list: inout Array<T>) {
        internalQuickSort(list: &list, low: 0, high: list.count - 1)
    }
    
    static func internalQuickSort<T: Comparable>(list: inout Array<T>, low: Int, high: Int) {
        if high <= low { return }
        var i = low
        var j = high
        let key = list[low]
        while true {
            while list[i] <= key {
                i+=1
                if i == high {break}
            }
            while list[j] > key {
                j-=1
                if j == low {break}
            }
            if i >= j { break }
            list.changeValue(index1: i, index2: j)
        }
        list.changeValue(index1: low, index2: j)
        internalQuickSort(list: &list, low: low, high: j-1)
        internalQuickSort(list: &list, low: j+1, high: high)
    }
    // MARK: 快速排序结束
    
    // MARK: 选择排序
    static func selectionSort<T:Comparable>(list: inout Array<T>) {
        var minIndex = 0
        var temp: T
        for i in 0..<list.count {
            minIndex = i
            for j in i..<list.count{
                if list[minIndex] > list[j] {
                    minIndex = j
                }
            }
            if minIndex != i {
                temp = list[minIndex]
                list[minIndex] = list[i]
                list[i] = temp
            }
        }
    }
    
    // MARK: 归并排序开始
    static func mergeSort<T:Comparable>(list: inout Array<T>) {
        var temp: Array<T> = [T]()
        internalMergeSort(list: &list, temp: &temp, left: 0, right: list.count-1);
    }
    
    private static func internalMergeSort<T:Comparable>(list: inout Array<T>, temp: inout Array<T>, left: Int, right: Int) {
        if left < right {
            let middle = (left + right) / 2
            internalMergeSort(list: &list, temp: &temp, left: left, right: middle)
            internalMergeSort(list: &list, temp: &temp, left: middle + 1, right: right)
            mergeSortedArray(list: &list, temp: &temp, left: left, middle: middle, right: right)
        }
    }
    
    private static func mergeSortedArray<T:Comparable>(list: inout Array<T>, temp: inout Array<T>, left: Int, middle: Int, right: Int) {
        temp.removeAll()
        var i = left
        var j = middle + 1
        while i <= middle, j <= right {
            if list[i] <= list[j] {
                temp.append(list[i])
                i += 1
            } else {
                temp.append(list[j])
                j += 1
            }
        }
        if i <= middle {
            temp.append(contentsOf: list[i...middle])
        }
        
        if j <= right {
            temp.append(contentsOf: list[j...right])
        }
        for i in 0..<temp.count {
            list[left + i] = temp[i]
        }
    }
    // MARK: 归并排序结束
}
