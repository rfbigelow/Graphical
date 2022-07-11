//
//  BreadthFirstSearch.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

/// An implementation of the breadth first search (BFS) algorithm.
///
/// This class runs breadth first search on the given graph and caches the results, which are available as a collection.
class BreadthFirstSearch: Collection {
    /// An element of a breadth first search consists of a vertex, its predecessor (if it has one), and the distance from the starting vertex.
    typealias Element = (v:Int, p: Int?, d: Int)
    
    /// The color of a vertex.
    private enum Color {
        /// A white vertex has not yet been visited.
        case white
        /// A gray vertex has been discovered, but is still being explored.
        case gray
        /// A black vertex has been fully explored, meaning that all of its adjacent vertices have been discovered.
        case black
    }

    private let g: Graph
    private var distance: [Int]
    private var predecessor: [Int?]
    
    /// Initializes a new `BreadthFirstSearch`, which runs the BFS algorithm on the given graph.
    ///
    /// - Parameters:
    ///  - graph: The `Graph` to search.
    ///  - startingVertex: The vertex to search from. Must be a vertex in the graph.
    init(graph: Graph, startingVertex: Int) {
        g = graph
        var color = Array(repeating: Color.white, count: g.vertexCount)
        distance = Array(repeating: Int.max, count: g.vertexCount)
        predecessor = Array(repeating: nil, count: g.vertexCount)
        
        color[startingVertex] = Color.gray
        distance[startingVertex] = 0
        predecessor[startingVertex] = nil
        let queue = Queue<Int>()
        queue.enqueue(startingVertex)
        
        while !queue.isEmpty {
            let next = queue.dequeue()
            for v in g.adjacent(v: next).filter({color[$0] == Color.white}) {
                color[v] = Color.gray
                distance[v] = distance[next] + 1
                predecessor[v] = next
                queue.enqueue(v)
            }
            color[next] = Color.black
            bfsOrder.append(next)
        }
    }

    /// Gets the vertices in the order they were visited by BFS.
    public private(set) var bfsOrder: [Int] = []
    
    /// Gets the result of the BFS for the vertex at the given position.
    ///
    /// - Returns: A tuple with the vertex, the vertex's predecessor (if it has one) and the distance from the source vertex.
    public subscript(position: Int) -> Element {
        precondition(position >= 0 && position < bfsOrder.count)
        return (v: position, p: predecessor[position], d: distance[position])
    }
    
    /// The first index in this collection.
    public var startIndex: Int {
        return bfsOrder.startIndex
    }
    
    /// The end index of this collection, which is one element past the end of the collection.
    public var endIndex: Int {
        return bfsOrder.endIndex
    }
    
    /// Returns the position immediately after the given index.
    public func index(after i: Int) -> Int {
        return bfsOrder.index(after: i)
    }
}
