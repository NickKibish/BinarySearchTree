//
//  BinarySearchTree.swift
//  Pods
//
//  Created by Mykola Kibysh on 6/20/17.
//
//

import Foundation
import NKQueue

public struct BinarySearchTree<Key: Comparable, Value>: ExpressibleByDictionaryLiteral {
    public init() { }
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            put(value: value, for: key)
        }
    }
    
    fileprivate class Node {
        var value: Value?
        var key: Key
        
        var leftNode: Node?
        var rightNode: Node?
        
        init(key: Key, value: Value?) {
            self.value = value
            self.key = key
        }
    }
    
    fileprivate var rootNode: Node?
}

// MARK: - Private Methods
extension BinarySearchTree {
    fileprivate func put(node: Node?, key: Key, value: Value?) -> Node {
        guard let node = node else {
            return Node(key: key, value: value)
        }
        
        if key < node.key {
            node.leftNode = put(node: node.leftNode, key: key, value: value)
        } else if key > node.key {
            node.rightNode = put(node: node.rightNode, key: key, value: value)
        } else {
            node.value = value
        }
        return node
    }
    
}

extension BinarySearchTree {
    public var min: Key? {
        return nil
    }
    
    public var max: Key? {
        return nil
    }
    
    public var isEmpty: Bool {
        return false
    }
    
    public var size: Int {
        return 0
    }
}

// MARK: - Public methods
extension BinarySearchTree {
    public subscript (key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set (value) {
            put(value: value, for: key)
        }
    }
    
    public mutating func put(value: Value?, for key: Key) {
        rootNode = put(node: rootNode, key: key, value: value)
    }
    
    public func value(for key: Key) -> Value? {
        var curr = rootNode
        while let node = curr {
            if key < node.key { curr = node.leftNode }
            else if key > node.key { curr = node.rightNode }
            else { return node.value }
        }
        return nil
    }
    
    public mutating func delete(at key: Key) {
        
    }
    
    public mutating func deleteAll() {
        
    }
    
    public func rank(at key: Key) -> Int {
        return 0
    }
    
    public func floor(for key: Key) -> Key? { return nil }
    
    public func ceiling(for key: Key) -> Key? { return nil }
}
