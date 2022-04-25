//
//  DigraphTests.swift
//  
//
//  Created by Robert Bigelow on 4/24/22.
//

import XCTest
import Graphical

class DigraphTests: XCTestCase {
    
    func testSingleVertex() {
        let g = Digraph(vertexCount: 1)
        XCTAssertEqual(g.vertexCount, 1, "Vertex count was not one")
        XCTAssertEqual(g.edgeCount, 0, "Edge count was not zero")
        XCTAssert(g.adjacent(v: 0).isEmpty, "Adjacency list was not empty")
    }
    
    func testMultipleVertices() {
        let vertexCount = 3
        let g = Digraph(vertexCount: vertexCount)
        XCTAssertEqual(g.vertexCount, vertexCount, "Vertex count was not \(vertexCount)")
        XCTAssertEqual(g.edgeCount, 0, "Edge count was not zero")
        for v in 0..<g.vertexCount {
            XCTAssert(g.adjacent(v: v).isEmpty, "Adjacency list for \(v) is not empty")
        }
    }
    
    func testAddEdge() {
        var g = Digraph(vertexCount: 2)
        g.addEdge(u: 0, v: 1)
        XCTAssertEqual(g.edgeCount, 1, "Edge count was not 1")
        XCTAssert(g.adjacent(v: 0).contains(1), "Adjacency list for 0 did not contain 1")
        XCTAssert(g.adjacent(v: 1).isEmpty, "Adjacency list for 1 was not empty")
    }
    
    func testAddSameEdgeTwice() {
        var g = Digraph(vertexCount: 2)
        g.addEdge(u: 0, v: 1)
        g.addEdge(u: 0, v: 1)
        XCTAssertEqual(g.edgeCount, 1, "Edge count was not 1")
        XCTAssert(g.adjacent(v: 0).contains(1), "Adjacency list for 0 did not contain 1")
        XCTAssert(g.adjacent(v: 1).isEmpty, "Adjacency list for 1 was not empty")
    }
    
    func testTranspose() {
        var g = Digraph(vertexCount: 2)
        g.addEdge(u: 0, v: 1)
        let gt = g.transpose()
        XCTAssertEqual(g.vertexCount, gt.vertexCount)
        XCTAssertEqual(g.edgeCount, gt.edgeCount)
        for u in 0..<g.vertexCount {
            for v in g.adjacent(v: u) {
                XCTAssert(gt.adjacent(v: v).contains(u), "g contains (\(u), \(v)) but gt does not contain (\(v), \(u))")
            }
        }
    }
}
