//
//  Digraph.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

struct Digraph: Graph {
    private var vertices: [[Int]]
    
    var vertexCount: Int {
        return vertices.count
    }
    
    private(set) var edgeCount: Int = 0
    
    init(vertexCount: Int) {
        precondition(vertexCount > 0)
        vertices = Array(repeating: [], count: vertexCount)
    }
    
    func adjacent(v: Int) -> [Int] {
        precondition(v >= 0 && v < vertices.count)
        return vertices[v]
    }
    
    func transpose() -> Graph {
        var g = Digraph(vertexCount: vertexCount)
        for u in 0..<vertexCount {
            for v in vertices[u] {
                g.addEdge(u: v, v: u)
            }
        }
        return g
    }
    
    mutating func addEdge(u: Int, v: Int) {
        precondition(u >= 0 && u < vertices.count)
        precondition(v >= 0 && v < vertices.count)
        guard !vertices[u].contains(v) else {
            return
        }
        vertices[u].append(v)
        edgeCount += 1
    }
}
