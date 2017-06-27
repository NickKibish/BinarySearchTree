//
//  BinarySearchTreeTests.swift
//  NKBinarySearchTree
//
//  Created by Mykola Kibysh on 6/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import NKBinarySearchTree

class BinarySearchTreeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSize() {
        var bst = BinarySearchTree<String, Int>()
        XCTAssertEqual(bst.size, 0)
        
        bst.put(value: 1, for: "1")
        XCTAssertEqual(bst.size, 1)
        
        bst["2"] = 2
        XCTAssertEqual(bst.size, 2)
        
        bst.delete(at: "1")
        XCTAssertEqual(bst.size, 1)
        
        bst.delete(at: "1")
        XCTAssertEqual(bst.size, 1)
        
        bst.deleteAll()
        XCTAssertEqual(bst.size, 0)
    }
    
    func testRank() {
        var bst = BinarySearchTree<String, String>()
        bst["S"] = "S"
        bst["E"] = "E"
        bst["X"] = "X"
        bst["A"] = "A"
        bst["R"] = "R"
        bst["C"] = "C"
        bst["H"] = "H"
        bst["M"] = "M"
        
        let rankS = bst.rank(for: "S")
        let rankX = bst.rank(for: "X")
        let rankZ = bst.rank(for: "Z")
        let rankA = bst.rank(for: "A")
        let rankH = bst.rank(for: "H")
        
        XCTAssertEqual(rankA, 0)
        XCTAssertEqual(rankS, 6)
        XCTAssertEqual(rankZ, 8)
        XCTAssertEqual(rankX, 7)
        XCTAssertEqual(rankH, 3)
    }
    
    func testMinMax() {
        var bst = BinarySearchTree<String, String>()
        bst["S"] = "S"
        bst["E"] = "E"
        bst["X"] = "X"
        bst["A"] = "A"
        bst["R"] = "R"
        bst["C"] = "C"
        bst["H"] = "H"
        bst["M"] = "M"
        
        let minKey = bst.min
        let maxKey = bst.max
        
        XCTAssertEqual(minKey, "A")
        XCTAssertEqual(maxKey, "X")
    }
    
    func testFloorAndCeiling() {
        var bst = BinarySearchTree<String, String>()
        bst["S"] = "S"
        bst["E"] = "E"
        bst["X"] = "X"
        bst["A"] = "A"
        bst["R"] = "R"
        bst["C"] = "C"
        bst["H"] = "H"
        bst["M"] = "M"

        let floorG = bst.floor(for: "G")
        let ceilingQ = bst.ceiling(for: "Q")
        let floorD = bst.floor(for: "D")
        let ceilingZ = bst.ceiling(for: "Z")
        let floor1 = bst.floor(for: "1") // `1` is less then 'A' symbol in ASCII table
        
        XCTAssertEqual(floorG, "E")
        XCTAssertEqual(ceilingQ, "R")
        XCTAssertEqual(floorD, "C")
        XCTAssertNil(ceilingZ)
        XCTAssertNil(floor1)
    }
    
}
