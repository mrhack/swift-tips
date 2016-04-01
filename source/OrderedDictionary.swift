//
//  OrderedDictionary.swift
//  swift-tips
//
//  Created by hdg on 16/3/8.
//  Copyright © 2016年 hdg. All rights reserved.
//

import Foundation

struct OrderedDictionary<K: Hashable, V> {
    var keys: Array<K> = []
    var values: Array<V> = []
    
    var count: Int {
        return self.keys.count
    }
    
    init(){}
    init( keys: Array<K>, widthValues values: Array<V> ) {
        // 个数相等
        guard keys.count == values.count else {
            NSException.raise(NSInvalidArgumentException, format: "items count not match", arguments: CVaListPointer(_fromUnsafeMutablePointer: UnsafeMutablePointer()))
            return
        }
        
        // 如果有多个key相同，则只保留第一个
        for (index, key) in keys.enumerate() {
            if !self.keys.contains(key) {
                self.keys.append(key)
                self.values.append(values[index])
            }
        }
    }
    
    subscript( index: Int ) -> V? {
        get {
            return self.values[index]
        }
        set(nv) {
            if nv != nil {
                self.values[index] = nv!
            } else {
                self.values.removeAtIndex(index)
                self.keys.removeAtIndex(index)
            }
        }
    }
    
    subscript( key: K ) -> V? {
        get {
            if let index = self.keys.indexOf(key) {
                return self.values[index]
            }
            return nil
        }
        set(nv) {
            if let index = self.keys.indexOf(key) {
                if nv == nil {
                    // remove
                    self.values.removeAtIndex(index)
                    self.keys.removeAtIndex(index)
                } else {
                    // update
                    self.values[ index ] = nv!
                }
            } else {
                if nv != nil {
                    // add
                    self.values.append(nv!)
                    self.keys.append(key)
                }
            }
        }
    }
    
    var description: String {
        var result = "{\n"
        for i in 0..<self.count {
            result += "\t[\(self.keys[i])] => \(self.values[i])\n"
        }
        result += "}"
        return result
    }
}