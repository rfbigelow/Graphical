//
//  QueueTests.swift
//  
//
//  Created by Robert Bigelow on 7/2/22.
//

import XCTest
import Graphical

class QueueTests: XCTestCase {
    func testEmptyQueue() {
        let queue = Queue<Int>()
        XCTAssert(queue.isEmpty, "New queue was not empty")
    }
    
    func testEnqueueSingleItem() throws {
        let queue = Queue<Int>()
        queue.enqueue(42)
        XCTAssert(!queue.isEmpty)
        let actual = queue.dequeue()
        XCTAssertEqual(42, actual, "Wrong item dequeued")
        XCTAssert(queue.isEmpty, "Dequeue of single element queue should empty the queue")
    }

    func testEnqueueMultipleItems() throws {
        let queue = Queue<Int>()
        for i in 0 ..< 3 {
            queue.enqueue(i)
        }
        for i in 0 ..< 3 {
            XCTAssertEqual(i, queue.dequeue())
        }
    }
}
