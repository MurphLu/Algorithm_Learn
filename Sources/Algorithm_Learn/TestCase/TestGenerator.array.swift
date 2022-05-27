//
//  File.swift
//  
//
//  Created by Murph on 2022/5/26.
//

import Foundation

extension TestGenerator {
    public static func testArrays(caseNum: Int, maxValue: Int, maxSize: Int) -> [[Int]] {
        var arr = [[Int]]()
        for i in 0...caseNum {
            arr.append(testArray(maxValue: maxValue, maxSize: maxSize))
        }
        return arr
    }

    private static func testArray(maxValue: Int, maxSize: Int) -> [Int] {
        let size = Int.random(in: 0...maxSize)
        var arr = [Int]()
        for i in 0...size {
            arr.append(Int.random(in: 0...maxValue) - Int.random(in: 0...maxValue))
        }
        return arr
    }
}
