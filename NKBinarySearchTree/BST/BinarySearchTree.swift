//
//  BinarySearchTree.swift
//  Pods
//
//  Created by Mykola Kibysh on 6/20/17.
//
//

import Foundation

public struct BinarySearchTree<Key: Comparable, Value>: ExpressibleByDictionaryLiteral {
    public init() {
        
    }
    
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            put(key: key, value: value)
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
    fileprivate mutating func put(key: Key, value: Value?) {
        rootNode = put(node: rootNode, key: key, value: value)
    }
    
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
    
    fileprivate func getValue(for key: Key) -> Value? {
        var curr = rootNode
        while let node = curr {
            if key < node.key { curr = node.leftNode }
            else if key > node.key { curr = node.rightNode }
            else { return node.value }
        }
        return nil
    }
}

// MARK: - Public methods
extension BinarySearchTree {
    public subscript (key: Key) -> Value? {
        get {
            return getValue(for: key)
        }
        set (value) {
            put(key: key, value: value)
        }
    }
    
    func deleteObject(at key: Key) {
        
    }
}
