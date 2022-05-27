//
//  File.swift
//  
//
//  Created by Murph on 2022/5/23.
//

import Foundation

extension Array {
    mutating public func swap(_ i: Int, _ j: Int) {
        let temp = self[j]
        self[j] = self[i]
        self[i] = temp
    }
}
