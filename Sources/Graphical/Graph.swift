//
//  Graph.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

protocol Graph {
    var vertexCount: Int { get }
    var edgeCount: Int { get }
    
    func adjacent(v: Int) -> [Int]
    
    func transpose() -> Graph
}
