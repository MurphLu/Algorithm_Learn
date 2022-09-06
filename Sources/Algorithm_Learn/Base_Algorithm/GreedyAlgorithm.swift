//
//  File.swift
//  
//
//  Created by Murph on 2022/9/1.
//

import Foundation

struct Project {
    let start: Int
    let end: Int
}

// 贪心算法
extension Algorithm {
    
    // MARK: - 会议安排
    // 有一个会议室，可用的开始时间为 <timePoint>, 有 n 个会议，每个会议有自己的开始时间和结束时间
    // 需要如何安排会议，才能让该会议室一天内完成最多的会议
    // 解法： 以会议结束时间为参考，会议最先结束的，最先安排，然后依次类推
    func arrangeProject(projs: [Project], timePoint: Int) -> [Project] {
        let arr = projs.sorted(by: { $0.end < $1.end })
        var result = [Project]()
        var temp = timePoint
        for proj in arr {
            if temp <= proj.start {
                result.append(proj)
                temp = proj.end
            }
        }
        return result
    }
    
    // MARK: - 字符串数组所有字符串组合为最小字典序长字符串
    //排序方式 $0 + $1 <= $1 + $0
    // 证明
    // 首先需要证明该比较具有传递性
    // a+b<= b+a, b+c <= c+b ==> a+c <= c+a
    // 可以将字符串看做进制为 k（小写字母的话k=26） 的数, k^n 我们来写成 m(n)
    // 1. a+b <= b+a ==> a*m(b) + b <= b*m(a) + a
    // 2. b+c <= c+b ==> b*m(c) + c <= c*m(b) + b
    
    // 将 1 减 b 乘 c 可得
    // a*m(b)*c <= b*m(a)*c + a*c - b*c
    // 将 2 减 b 乘 a 可得
    // b*m(c)*a - b*a + c*a <= c*m(b)*a
    // 结果结合
    // b*m(c)*a - b*a + c*a <= b*m(a)*c + a*c - b*c
    // b*m(c)*a - b*a <= b*m(a)*c - b*c
    // a*m(c) - a <= c*m(a) - c
    // a*m(c) + c <= c*m(a) + a
    // a+c <= c+a
    // 按上面的方式排完续之后，交换任何两个不等元素，都会导致最后生成的字符串有更大的字典序
    func minString(arr: [String]) -> String {
        let sorted = arr.sorted(by: { $0 + $1 < $1 + $0 })
        return sorted.joined(separator: "")
    }
    
    // MARK: - 所有排列中最大的和
    /// 解题思路
    /// 统计索引范围数组中每个索引出现的次数，将出现次数降序排列
    /// 由于只要最终结果，所以，将数组降序排列，使得越大的数字出现的次数越多即可
    /// 难点：统计每个索引出现的次数
    /// 解决方案：差分数组（暴力遍历的话容易超时）
    /// 建一个长度为 nums.count + 1 的数组，初始值为 0
    /// 遍历 范围数组，将 范围开始的索引位置值 +1，将范围结束的索引位置的下一位 -1
    /// 遍历完成之后将新数组中每一个索引位置值与前一位置值相加，即可得到每个索引最终出现的次数
    /// 按降序排列，即可得到由大到小，每个数字出现的次数，最终计算即可得出结果
    ///
    func maxSumRangeQuery(_ nums: [Int], _ requests: [[Int]]) -> Int {
        var result = 0
        let ordered = nums.sorted(by: { $0 > $1})

        var cnt = Array(repeating: 0, count: nums.count + 1)
        
        for request in requests {
            let start = request[0]
            let end = request[1]
            cnt[start] += 1
            cnt[end + 1] -= 1
        }
        for i in 1..<cnt.count {
            cnt[i] += cnt[i-1]
        }
        cnt.sort(by: { $0 > $1 })
        let newCnt = cnt.filter({ $0 > 0 })
        
        for (i, v) in newCnt.enumerated() {
            result += ordered[i] * v
        }
        return result % (Int(truncating: NSDecimalNumber(decimal: pow(10,9))) + 7)
    }
    
    // MARK: - 最大数
    /// 给定一组非负整数 nums，重新排列每个数的顺序（每个数不可拆分）使之组成一个最大的整数。
    /// 方法类似于 字符串数组所有字符串组合为最小字典序长字符串
    /// 因为直接拼接，所以直接使用字典序来判断
    func largestNumber(_ nums: [Int]) -> String {
        var newArr = nums.map({ "\($0)" })
        newArr.sort(by: { $0 + $1 > $1 + $0 })
        while newArr.first == "0" && newArr.count > 1 { newArr.removeFirst() }
        return newArr.joined(separator: "")
    }
    
    // MARK: - 分割金条
    /// 一块金条分成两半，无论切成两份多大的，最终花费的都是块金条长度一样的铜板
    /// 给定一个数组，返回分割最小的代价
    ///
    func curGold(_ nums: [Int]) -> Int {
        let queue = PriorityQueue<Int>(list: nums) { o1, o2 in
            o1 < 02
        }
        var sum = 0
        while !queue.isEmpty() {
            let val1 = queue.pop()!
            let val2 = queue.pop()!
            sum += (val1 + val2)
            if !queue.isEmpty() { queue.push(sum) }
        }
        return sum
    }
    
    // MARK: - 安排工作以达到最大收益
    /**
    你有 n 个工作和 m 个工人。给定三个数组： difficulty, profit 和 worker ，其中:
    
    difficulty[i] 表示第 i 个工作的难度，profit[i] 表示第 i 个工作的收益。
    worker[i] 是第 i 个工人的能力，即该工人只能完成难度小于等于 worker[i] 的工作。
    每个工人 最多 只能安排 一个 工作，但是一个工作可以 完成多次 。

    举个例子，如果 3 个工人都尝试完成一份报酬为 $1 的同样工作，那么总收益为 $3 。如果一个工人不能完成任何工作，他的收益为 $0 。
    返回 在把工人分配到工作岗位后，我们所能获得的最大利润 。

    来源：力扣（LeetCode）
    链接：https://leetcode.cn/problems/most-profit-assigning-work
    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
    */
    func maxProfitAssignment(_ difficulty: [Int], _ profit: [Int], _ worker: [Int]) -> Int {
        var workList = [(difficulty: Int, profit: Int)]()
        for i in 0..<difficulty.count {
            workList.append((difficulty[i], profit[i]))
        }
        let sorted = workList.sorted(by: {$0.profit > $1.profit || (($0.profit == $1.profit) && ($0.difficulty < $1.difficulty))})
        var result = 0
        for work in worker {
            let find = sorted.first(where: { $0.difficulty <= work })
            result += find?.profit ?? 0
        }
        return result
    }
    
    // MARK: - 最小字符串
    /// 给你一个字符串 s ，请你去除字符串中重复的字母，使得每个字母只出现一次。需保证 返回结果的字典序最小（要求不能打乱其他字符的相对位置）。
    /// 解法：单调栈
    func removeDuplicateLetters(_ s: String) -> String {
        let chars = Array(s)
        var result = [Character]()
        var mapCount = [Character: Int]()
        for char in chars {
            mapCount[char] = (mapCount[char] ?? 0) + 1
        }
        
        for i in 0..<chars.count {
            let char = chars[i]
            mapCount[char]! -= 1
            if result.contains(char) { continue }
            
            while let last = result.last, last > char, mapCount[last]! > 0 {
                result.removeLast()
            }
            if !result.contains(char) {
                result.append(char)
            }
        }
        return String(result)
    }
}
