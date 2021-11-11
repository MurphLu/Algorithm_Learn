//
//  String_Extension.swift
//  
//
//  Created by Murph on 2021/10/25.
//

import Foundation

extension String {
    func subString(from: Int, to: Int) -> String {
        if from >= to { return "" }
        if from > self.count - 1 {
            return ""
        }
        if to > self.count - 1 {
            let startIndex = self.index(self.startIndex, offsetBy: from)
            return String(self[startIndex..<self.endIndex])
        }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
    
    func subString(location: Int, length: Int) -> String {
        let from = location
        let to = location + length
        if from >= to { return "" }
        if from > self.count - 1 {
            return ""
        }
        if to > self.count - 1 {
            let startIndex = self.index(self.startIndex, offsetBy: from)
            return String(self[startIndex..<self.endIndex])
        }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
    
    func subString(range: Range<Int>) -> String {
        if range.startIndex > self.count - 1 {
            return ""
        }
        if range.endIndex > self.count - 1 {
            let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
            return String(self[startIndex..<self.endIndex])
        }
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let endIndex = self.index(self.startIndex, offsetBy: range.endIndex)
        return String(self[startIndex..<endIndex])
    }
}
