//
//  UndirectedGraph.swift
//  
//
//  Created by Robert Bigelow on 4/30/22.
//

public struct UndirectedGraph {
    private var vertices: [[Int]]
    public private(set) var edgeCount: Int
    
    public init(vertexCount: Int) {
        precondition(vertexCount > 0)
        vertices = Array(repeating: [], count: vertexCount)
        edgeCount = 0
    }
    
    public mutating func addEdge(u: Int, v: Int) {
        precondition(u >= 0 && u < vertices.count)
        precondition(v >= 0 && v < vertices.count)
        guard !vertices[u].contains(v) else {
            return
        }
        vertices[u].append(v)
        if u != v {
            vertices[v].append(u)
        }
        edgeCount += 1
    }
}

extension UndirectedGraph: Graph {
    public var vertexCount: Int {
        return vertices.count
    }
    
    public func adjacent(v: Int) -> [Int] {
        precondition(v >= 0 && v < vertexCount)
        return vertices[v]
    }
}
