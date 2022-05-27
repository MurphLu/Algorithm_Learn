//
//  File.swift
//  
//
//  Created by Murph on 2022/5/25.
//

import Foundation

extension Find {
    public static func findOddTimers(arr: Array<Int>) -> Int{
        var oddTimesNum = 0
        
        for num in arr {
            oddTimesNum ^= num
        }
        print(oddTimesNum)
        return oddTimesNum
    }
    
    public static func findOddTimersTwo(arr: Array<Int>) -> (Int, Int){
        var eor = 0
        for num in arr {
            eor ^= num
        }
        // 取异或结果最后一位 1，那么数组中两个出现奇数次的数，在这一位上必定有一个为 0 一个为 1
        let rightOne = eor & (~eor + 1)
        var onlyOne: Int = 0
        for num in arr {
            // 通过 num & 整个数组异或结果中最后一位 1，就将数组分为两类，
            // 同时也将两个出现奇数次的数分开，这样就得到了两个数组，每个数组中只有一个数出现奇数次
            if num & rightOne == 0 {
                onlyOne ^= num
            }
        }
        return (onlyOne, eor ^ onlyOne)
    }
    
    
}
