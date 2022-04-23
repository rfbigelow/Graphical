//
//  DepthFirstSearch.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

class DepthFirstSearch: Collection {
    typealias Element = (v: Int, p: Int?, d: Int, f: Int)
    typealias Edge = (u: Int, v: Int)
    
    enum Color {
        case white
        case gray
        case black
    }
    
    enum EdgeType {
        case tree
    }
    
    private let g: Graph
    private var color: [Color]
    private var discovered: [Int]
    private var finished: [Int]
    private var edgeType: [EdgeType?]
    private var predecessor: [Int?]
    private var time = 0
    
    private(set) var hasCycle = false
    
    init(graph: Graph, visitOrder: [Int]? = nil) {
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
    
    var startOrder: [Element] {
        return Array(self.sorted(by: {$0.d < $1.d}))
    }
    
    var finishOrder: [Element] {
        return Array(self.sorted(by: {$0.f < $1.f}))
    }
    
    subscript(position: Int) -> Element {
        precondition(position >= startIndex && position < endIndex)
        let v = position
        return (v: v, p: predecessor[v], d: discovered[v], f: finished[v])
    }
    
    var treeEdges: [Edge] {
        return (0..<g.vertexCount).filter({edgeType[$0] != nil && edgeType[$0]! == EdgeType.tree}).map({(u: predecessor[$0]!, v: $0)})
    }
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return g.vertexCount
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    private func dfsVisit(s: Int) {
        var start = [s]
        var finish: [Int] = []
        
        while !start.isEmpty || !finish.isEmpty {
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
            
            while let u = finish.last, g.adjacent(v: u).allSatisfy({color[$0] != Color.white}) {
                color[u] = Color.black
                time += 1
                finished[u] = time
                finish.removeLast()
            }
        }
    }
}

func topologicalSort(g: Digraph) -> [Int] {
    let dfs = DepthFirstSearch(graph: g)
    return dfs.hasCycle ? [] : Array(dfs.finishOrder.map({$0.v}).reversed())
}

func connectedComponents(g: Graph) -> [[Int]] {
    let dfs = DepthFirstSearch(graph: g)
    let gt = g.transpose()
    let order = Array(dfs.sorted(by: {$0.f > $1.f}).map({$0.v}))
    let dfst = DepthFirstSearch(graph: gt, visitOrder: order)
    let components = slice(s: Array(dfst.startOrder), predicate: {$0.p == nil})
    return components.map({$0.map({$0.v})})
}
