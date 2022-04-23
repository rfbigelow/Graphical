//
//  Utility.swift
//  
//
//  Created by Robert Bigelow on 4/23/22.
//

func slice<T>(s: [T], predicate: (_ element: T) -> Bool) -> [[T]] {
    let indices = Array(s.enumerated().filter({predicate($0.element)}).map({$0.offset})) + [s.endIndex];
    let pairs = zip(indices.prefix(indices.count - 1), indices.suffix(indices.count - 1))
    var slices: [[T]] = []
    for p in pairs {
        let slice = Array(s[p.0..<p.1])
        slices.append(slice)
    }
    return slices
}
