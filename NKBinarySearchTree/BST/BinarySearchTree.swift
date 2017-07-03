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

//MARK: - Floor / Ceiling methods 
extension BinarySearchTree {
    fileprivate func floor(node: Node?, for key: Key) -> Node? {
        guard let node = node else {
            return nil
        }
    
        if key == node.key {
            return node
        } else if key < node.key {
            return floor(node: node.leftNode, for: key)
        }
        
        guard let rightNode = floor(node: node.rightNode, for: key) else {
            return node
        }
        
        return rightNode
    }
    
    fileprivate func ceiling(node: Node?, for key: Key) -> Node? {
        guard let node = node else {
            return nil
        }
        
        if key == node.key {
            return node
        } else if key > node.key {
            return ceiling(node: node.rightNode, for: key)
        }
        
        guard let leftNode = ceiling(node: node.leftNode, for: key) else {
            return node
        }
        
        return leftNode
    }
}

// MARK: - Min / Max methods
extension BinarySearchTree {
    fileprivate func min(node: Node?) -> Node? {
        guard let leftNode = node?.leftNode else {
            return node
        }
        return min(node: leftNode)
    }
    
    fileprivate func max(node: Node?) -> Node? {
        guard let rightNode = node?.rightNode else {
            return node
        }
        return max(node: rightNode)
    }
}

// MARK: - Public values
extension BinarySearchTree {
    public var min: Key? {
        return min(node: rootNode)?.key
    }
    
    public var max: Key? {
        return max(node: rootNode)?.key
    }
    
    public var isEmpty: Bool {
        return (rootNode?.count ?? 0) == 0
    }
    
    public var size: Int {
        return rootNode?.count ?? 0
    }
}

// MARK: - Deletion methods
extension BinarySearchTree {
    fileprivate func deleteMin(node: Node?) -> Node? {
        guard let n = node,
            let leftNode = node?.leftNode else {
            return node?.rightNode
        }
        
        n.leftNode = deleteMin(node: leftNode)
        n.count = 1 + n.leftNodeCount + n.rightNodeCount
        return n
    }
    
    fileprivate func delete(node: Node?, for key: Key) -> Node? {
        guard let node = node else { return nil }
        var tNode: Node? = node
        if key < node.key {
            tNode?.leftNode = delete(node: node.leftNode, for: key)
        } else if key > node.key {
            tNode?.rightNode = delete(node: node.rightNode, for: key)
        } else {
            guard let _ = node.rightNode else { return node.leftNode }
            guard let _ = node.leftNode else { return node.rightNode }
            
            tNode = min(node: node.rightNode)
            tNode?.rightNode = deleteMin(node: node.rightNode)
            tNode?.leftNode = node.leftNode
        }
        let lnc = tNode?.leftNodeCount ?? 0
        let rnc = tNode?.rightNodeCount ?? 0
        
        tNode?.count = lnc + rnc + 1
        return tNode
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
    
    public mutating func deleteMin() {
        if let node = rootNode {
            rootNode = deleteMin(node: node)
        }
    }
    
    public mutating func delete(at key: Key) {
        rootNode = delete(node: rootNode, for: key)
    }
    
    public mutating func deleteAll() {
        rootNode = nil
    }
    
    public func rank(for key: Key) -> Int {
        return rank(in: rootNode, for: key)
    }
    
    /// Largest Key <= given key
    ///
    /// - Parameter key: given key
    /// - Returns: Largest Key
    public func floor(for key: Key) -> Key? {
        return floor(node: rootNode, for: key)?.key
    }
    
    /// Smallest key >= given key
    ///
    /// - Parameter key: given key
    /// - Returns: Smallest key
    public func ceiling(for key: Key) -> Key? {
        return ceiling(node: rootNode, for: key)?.key
    }
}
