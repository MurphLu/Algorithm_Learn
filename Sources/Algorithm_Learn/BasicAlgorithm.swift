//
//  File.swift
//  
//
//  Created by Murph on 2021/11/11.
//

import Foundation

class BasicAlgorithm {
    // 冒泡排序
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
    
    //选择排序
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
    
    // 插入排序
    static func insertSort<T:Comparable>(list: inout Array<T>) {
        for i in 1..<list.count {
            let value = list[i]
            var position = i
            while position > 0 && list[position-1] > value {
                list[position] = list[position-1]
                position-=1
            }
            list[position] = value
        }
    }
    
    // MARK:  归并排序开始
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
    // MARK:  归并排序结束
    
    // 二分查找
    static func binarySearch<T: Comparable>(list: Array<T>, target: T) -> Int {
        var left = 0, right = list.count - 1
        while left <= right {
            let mid = (left + right) / 2
            if list[mid] == target {
                return mid
            } else if list[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return left
    }
    
    // 合并两个有序链表
    static func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        guard let l1 = l1 else {
            return l2
        }
        guard let l2 = l2 else{
            return l1
        }
        let nextRound1 = l1.next
        let nextRound2 = l2.next
        if l1.val <= l2.val {
            l1.next = mergeTwoLists(nextRound1, l2)
            return l1
        } else {
            l2.next = mergeTwoLists(l1, nextRound2)
            return l2
        }
    }
    
    //翻转链表
    static func reverseNodeList(_ head: ListNode?) -> ListNode? {
        if head?.next == nil { return head }
        var current = head?.next
        head?.next = nil
        var result = head
        while let temp = current {
            current = temp.next
            temp.next = result
            result = temp
        }
        return result
    }
}
