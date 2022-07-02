//
//  Queue.swift
//  
//
//  Created by Robert Bigelow on 7/2/22.
//

public final class Queue<T> {
    private final class Node {
        var item: T
        var next: Node?
        
        init(item: T) {
            self.item = item
        }
    }
    
    private var first: Node?
    private var last: Node?
    
    public var isEmpty: Bool {
        return first == nil
    }
    
    public init() {}
    
    public func enqueue(_ item: T) {
        let node = Node(item: item)
        last?.next = node
        last = node
        if first == nil {
            first = node
        }
    }
    
    public func dequeue() -> T {
        precondition(!isEmpty)
        let dequeued = first
        first = dequeued!.next
        if last === dequeued {
            last = first
        }
        return dequeued!.item
    }
}
