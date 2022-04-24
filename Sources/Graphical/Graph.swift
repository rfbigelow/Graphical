//
//  Graph.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

/// A mathematical graph object.
///
/// Adopt the Graph protocol to allow your type to be traversed by graph algorithms.
public protocol Graph {
    
    /// The number of vertices in the graph.
    var vertexCount: Int { get }
    
    /// The number of edges in the graph.
    var edgeCount: Int { get }
    
    /// Gets an array containing the vertices that are adjacent to `v`.
    ///
    /// - Parameters:
    ///  - v: The vertex for which to get the adjacency list. Must be greater than or equal to `0` and less than `vertexCount`.
    func adjacent(v: Int) -> [Int]
    
    /// Transposes the graph, returning a new graph.
    ///
    /// - Returns: A new graph containing the transpose.
    func transpose() -> Graph
}
