//
//  DepthFirstSearch.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

/// An implementation of the depth first search (DFS) algorithm.
///
///  This class runs the depth first search algorithm on the given graph and caches the results, making them available as a collection.
public class DepthFirstSearch: Collection {
    public typealias Element = (v: Int, p: Int?, d: Int, f: Int)
    public typealias Edge = (u: Int, v: Int)
    
    /// The color of a vertex during the search.
    enum Color {
        /// A white vertex has not been discovered yet.
        case white
        /// A gray vertex has been discovered, but not fully explored.
        case gray
        /// A black vertex has been fully explored.
        case black
    }
    
    /// A classification of an edge.
    enum EdgeType {
        /// Tree edges are edges that are on a DFS path. All tree edges together make up the depth first forest of the graph.
        case tree
    }
    
    private let g: Graph
    private var color: [Color]
    private var discovered: [Int]
    private var finished: [Int]
    private var edgeType: [EdgeType?]
    private var predecessor: [Int?]
    private var time = 0
    
    /// Initializes a `DepthFirstSearch`, performing a search on the given graph.
    ///
    /// - Parameters:
    ///  - graph: The graph to search.
    ///  - visitOrder: An optional array which controls the order in which the vertices of the graph are explored.
    public init(graph: Graph, visitOrder: [Int]? = nil) {
        precondition(visitOrder == nil || visitOrder!.count == graph.vertexCount)
        g = graph
        color = Array(repeating: Color.white, count: g.vertexCount)
        discovered = Array(repeating: 0, count: g.vertexCount)
        finished = Array(repeating: 0, count: g.vertexCount)
        edgeType = Array(repeating: nil, count: g.vertexCount)
        predecessor = Array(repeating: nil, count: g.vertexCount)
        var work = visitOrder != nil ? Array(visitOrder!.reversed()) : Array((0..<g.vertexCount).reversed())
        while !work.isEmpty {
            let v = work.removeLast()
            guard color[v] == Color.white else {
                continue
            }
            dfsVisit(s: v)
        }
    }
    
    /// A flag which indicates if a cycle in the graph was detected.
    public private(set) var hasCycle = false
    
    /// Gets an array containing the search results for the vertices in the order that they were discovered.
    public var startOrder: [Element] {
        return Array(self.sorted(by: {$0.d < $1.d}))
    }
    
    /// Gets an array containing the search results for the vertices in the order for which exploration of the vertex finished.
    public var finishOrder: [Element] {
        return Array(self.sorted(by: {$0.f < $1.f}))
    }
    
    /// Gets the search result for the vertex at the given position.
    public subscript(position: Int) -> Element {
        precondition(position >= startIndex && position < endIndex)
        let v = position
        return (v: v, p: predecessor[v], d: discovered[v], f: finished[v])
    }
    
    /// Gets an array of all the tree edges in the graph, which constitutes the depth first forest.
    public var treeEdges: [Edge] {
        return (0..<g.vertexCount).filter({edgeType[$0] != nil && edgeType[$0]! == EdgeType.tree}).map({(u: predecessor[$0]!, v: $0)})
    }
    
    /// The first index in this collection.
    public var startIndex: Int {
        return 0
    }
    
    /// The end index of this collection, which is one element past the end of the collection.
    public var endIndex: Int {
        return g.vertexCount
    }
    
    /// Returns the position immediately following the given index.
    public func index(after i: Int) -> Int {
        guard i < endIndex else {
            return endIndex
        }
        return i + 1
    }
    
    /// Performs a depth first search from the given vertex.
    ///
    /// This function uses an iterative algorithm that employs 2 queues to simulate the parenthetical nature of a recursive implementation. This allows us to mark start and finish times for each vertex. This information can be used to derive a number of interesting properties or implement other algorithms.
    ///
    /// - Parameters:
    ///  - s: The vertex to start the search from.
    private func dfsVisit(s: Int) {
        var start = [s]
        var finish: [Int] = []
        
        while !start.isEmpty || !finish.isEmpty {
            
            // process verts in the start stack
            if !start.isEmpty {
                let u = start.removeLast()
                guard color[u] == Color.white else {
                    continue
                }
                time += 1
                discovered[u] = time
                color[u] = Color.gray
                finish.append(u)
                
                for v in g.adjacent(v: u) {
                    guard color[v] == Color.white else {
                        hasCycle = true
                        continue
                    }
                    predecessor[v] = u
                    edgeType[v] = EdgeType.tree
                    start.append(v)
                }
            }
            
            // process verts in the finish stack
            while let u = finish.last, g.adjacent(v: u).allSatisfy({color[$0] != Color.white}) {
                color[u] = Color.black
                time += 1
                finished[u] = time
                finish.removeLast()
            }
        }
    }
}

/// Performs a topological sort of the given directed graph.
///
/// - Parameters:
///  - g: The directed graph to perform the sort on.
///
///- Returns: The vertices of `g` in topological order.
public func topologicalSort(g: Digraph) -> [Int] {
    let dfs = DepthFirstSearch(graph: g)
    return dfs.hasCycle ? [] : Array(dfs.finishOrder.map({$0.v}).reversed())
}

/// Finds the connected components of the given graph.
///
/// - Parameters:
///  - g: The graph to find the connected components of.
///
/// - Returns: An array of arrays, each of which contains the vertices of one of the connected components of `g`.
public func connectedComponents(g: Graph) -> [[Int]] {
    let dfs = DepthFirstSearch(graph: g)
    let gt = g.transpose()
    let order = Array(dfs.sorted(by: {$0.f > $1.f}).map({$0.v}))
    let dfst = DepthFirstSearch(graph: gt, visitOrder: order)
    let components = slice(s: Array(dfst.startOrder), predicate: {$0.p == nil})
    return components.map({$0.map({$0.v})})
}
