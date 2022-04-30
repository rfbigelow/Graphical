//
//  Digraph.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

/// A directed graph.
public struct Digraph {
    private var vertices: [[Int]]
    
    /// Gets the number of edges in the graph.
    public private(set) var edgeCount: Int = 0
    
    /// Initializes a new `Digraph` with the specified number of vertices.
    ///
    /// The number of vertices is fixed at creation time.
    public init(vertexCount: Int) {
        precondition(vertexCount > 0)
        vertices = Array(repeating: [], count: vertexCount)
    }
    
    /// Adds a directed  edge from `u` to `v` to the graph.
    ///
    ///  - Parameters:
    ///     - u: The source vertex, which must be greater than or equal to `0` and less than `vertexCount`.
    ///     - v: The target vertex, which must be greater than or equal to `0` and less than `vertexCount`.
    public mutating func addEdge(u: Int, v: Int) {
        precondition(u >= 0 && u < vertices.count)
        precondition(v >= 0 && v < vertices.count)
        guard !vertices[u].contains(v) else {
            return
        }
        vertices[u].append(v)
        edgeCount += 1
    }
}

extension Digraph: Graph {
    /// Gets the number of vertices in the graph.
    public var vertexCount: Int {
        return vertices.count
    }
   
    /// Gets an array containing the vertices that are adjacent to `v`.
    ///
    /// - Parameters:
    ///  - v: The vertex for which to get the adjacency list. Must be greater than or equal to `0` and less than `vertexCount`.
    public func adjacent(v: Int) -> [Int] {
        precondition(v >= 0 && v < vertices.count)
        return vertices[v]
    }
    
    /// Transposes the graph, returning a new graph.
    ///
    /// - Returns: A new graph containing the transpose.
    public func transpose() -> Graph {
        var g = Digraph(vertexCount: vertexCount)
        for u in 0..<vertexCount {
            for v in vertices[u] {
                g.addEdge(u: v, v: u)
            }
        }
        return g
    }
}
