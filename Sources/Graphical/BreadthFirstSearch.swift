//
//  BreadthFirstSearch.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

class BreadthFirstSearch: Collection {
    typealias Element = (v:Int, p: Int?, d: Int)
    
    enum Color {
        case white
        case gray
        case black
    }

    private let g: Graph
    private var color: [Color]
    private var distance: [Int]
    private var predecessor: [Int?]
    private var queue: [Int] = []
    private var bfsOrder: [Int] = []
    
    init(graph: Graph, startingVertex: Int) {
        g = graph
        color = Array(repeating: Color.white, count: g.vertexCount)
        distance = Array(repeating: Int.max, count: g.vertexCount)
        predecessor = Array(repeating: nil, count: g.vertexCount)
        
        color[startingVertex] = Color.gray
        distance[startingVertex] = 0
        predecessor[startingVertex] = nil
        queue.append(startingVertex)
        
        while !queue.isEmpty {
            let next = queue.remove(at: 0)
            for v in g.adjacent(v: next).filter({color[$0] == Color.white}) {
                color[v] = Color.gray
                distance[v] = distance[next] + 1
                predecessor[v] = next
                queue.append(v)
            }
            color[next] = Color.black
            bfsOrder.append(next)
        }
    }
    
    subscript(position: Int) -> Element {
        precondition(position >= 0 && position < bfsOrder.count)
        let v = bfsOrder[position]
        return (v: v, p: predecessor[v], d: distance[v])
    }
    
    var startIndex: Int {
        return bfsOrder.startIndex
    }
    
    var endIndex: Int {
        return bfsOrder.endIndex
    }
    
    func index(after i: Int) -> Int {
        return bfsOrder.index(after: i)
    }
}
