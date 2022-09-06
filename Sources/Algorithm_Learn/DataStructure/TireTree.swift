//
//  TireTree.swift
//  
//
//  Created by Murph on 2022/9/1.
//

import Foundation

// 只适用纯小写字母字符串，如果字符种类多的话可以使用 map
fileprivate class TireNode {
    var pass = 0
    var end = 0
    var nexts = Array<TireNode?>(repeating: nil, count: 26)
}

class Tire {
    private let root: TireNode
    
    init() {
        root = TireNode()
    }
    
    public func insert(word: String?) {
        guard let word = word else { return }
        let chs = Array(word)
        var node = root
        node.pass += 1
        if word.isEmpty {
            node.end += 1
            return
        }
        for ch in chs {
            let index = Int(ch.asciiValue! - Character("a").asciiValue!)
            node.nexts[index] = node.nexts[index] ?? TireNode()
            node = node.nexts[index]!
            node.pass += 1
        }
        node.end += 1
    }
    
    // 查找某个字符串加入前缀树几次
    public func search(word: String) -> Int {
        let chs = Array(word)
        var node = root
        for ch in chs {
            let index = Int(ch.asciiValue! - Character("a").asciiValue!)
            guard let temp = node.nexts[index] else {
                return 0
            }
            node = temp
        }
        return node.end
    }
    
    // 所有加入的字符串中，有几个是以 pre 这个字符串作为前缀的
    public func prefixNumber(pre: String) -> Int {
        let chs = Array(pre)
        var node = root
        for ch in chs {
            let index = Int(ch.asciiValue! - Character("a").asciiValue!)
            guard let temp = node.nexts[index] else {
                return 0
            }
            node = temp
        }
        return node.pass
    }
    
    //检查加入的字符串中是否有 word 的前缀
    public func checkPrefix(word: String) -> Bool {
        guard !word.isEmpty else { return false }
        let chs = Array(word)
        var node = root
        for ch in chs {
            let index = Int(ch.asciiValue! - Character("a").asciiValue!)
            if let temp = node.nexts[index] {
                if temp.end > 0 {
                    return true
                }
                node = temp
            } else {
                return false
            }
        }
        return node.end > 0
    }
    
    public func delete(word: String) {
        guard search(word: word) > 0 else { return }
        var node = root
        let chs = Array(word)
        node.pass -= 1
        for ch in chs {
            let index = Int(ch.asciiValue! - Character("a").asciiValue!)
            let temp = node.nexts[index]!
            if temp.pass == 1 {
                node.nexts[index] = nil
                return
            }
            node = temp
        }
        node.end -= 1
    }
}
