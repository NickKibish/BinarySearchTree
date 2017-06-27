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
        var count: Int = 1
        
        var leftNode: Node?
        var rightNode: Node?
        
        init(key: Key, value: Value?) {
            self.value = value
            self.key = key
        }
        
        var leftNodeCount: Int { return leftNode?.count ?? 0 }
        var rightNodeCount: Int { return rightNode?.count ?? 0 }
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
        node.count = 1 + node.leftNodeCount + node.rightNodeCount
        return node
    }
    
}

// MARK: - Rank methods
extension BinarySearchTree {
    fileprivate func rank(in node: Node?, for key: Key) -> Int {
        guard let n = node else {
            return 0
        }
        
        if key < n.key {
            return rank(in: n.leftNode, for: key)
        } else if key > n.key {
            return 1 + n.leftNodeCount + rank(in: n.rightNode, for: key)
        }
        return n.leftNodeCount
    }
}

extension BinarySearchTree {
    public var min: Key? {
        var startNode = rootNode
        var key = rootNode?.key
        
        while let node = startNode?.leftNode {
            key = node.key
            startNode = node
        }
        
        return key
    }
    
    public var max: Key? {
        var startNode = rootNode
        var key = rootNode?.key
        
        while let node = startNode?.rightNode {
            key = node.key
            startNode = node
        }
        
        return key
    }
    
    public var isEmpty: Bool {
        return false
    }
    
    public var size: Int {
        return rootNode?.count ?? 0
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
    
    public func rank(for key: Key) -> Int {
        return rank(in: rootNode, for: key)
    }
    
    public func floor(for key: Key) -> Key? { return nil }
    
    public func ceiling(for key: Key) -> Key? { return nil }
}
