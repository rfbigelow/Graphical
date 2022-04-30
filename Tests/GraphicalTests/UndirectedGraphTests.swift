//
//  UndirectedGraphTests.swift
//  
//
//  Created by Robert Bigelow on 4/30/22.
//

import XCTest
import Graphical

class UndirectedGraphTests: XCTestCase {
    func testSingleVerted() {
        let g = UndirectedGraph(vertexCount: 1)
        XCTAssertEqual(g.vertexCount, 1, "Vertex count was not 1")
        XCTAssertEqual(g.edgeCount, 0, "Edge count was not zero")
        XCTAssert(g.adjacent(v: 0).isEmpty, "Vertex 0 adjacency list was not empty")
    }
    
    func testAddSelfEdge() {
        var g = UndirectedGraph(vertexCount: 1)
        g.addEdge(u: 0, v: 0)
        XCTAssertEqual(g.edgeCount, 1, "Edge count was not 1")
        XCTAssertEqual(g.adjacent(v: 0).count, 1, "Vertex 0 adjacency list should contain 1 vertex")
        XCTAssert(g.adjacent(v: 0).contains(0), "Vertex 0 should be adjacent to itself")
    }
    
    func testAddEdge() {
        var g = UndirectedGraph(vertexCount: 2)
        g.addEdge(u: 0, v: 1)
        XCTAssertEqual(g.edgeCount, 1, "Edge count was not 1")
        XCTAssertEqual(g.adjacent(v: 0).count, 1, "Vertex 0 adjacency list should contain 1 vertex")
        XCTAssertEqual(g.adjacent(v: 1).count, 1, "Vertex 1 adjacency list should contain 1 vertex")
        XCTAssert(g.adjacent(v: 0).contains(1), "Adjacency list for 0 does not contain 1")
        XCTAssert(g.adjacent(v: 1).contains(0), "Adjacency list for 0 does not contain 1")
    }
    
    func testAddSameEdgeTwice() {
        var g = UndirectedGraph(vertexCount: 2)
        g.addEdge(u: 0, v: 1)
        g.addEdge(u: 0, v: 1)
        XCTAssertEqual(g.edgeCount, 1, "Edge count was not 1")
        XCTAssertEqual(g.adjacent(v: 0).count, 1, "Vertex 0 adjacency list should contain 1 vertex")
        XCTAssertEqual(g.adjacent(v: 1).count, 1, "Vertex 1 adjacency list should contain 1 vertex")
    }
}
