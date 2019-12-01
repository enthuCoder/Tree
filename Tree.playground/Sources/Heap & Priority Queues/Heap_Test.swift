import Foundation

public class Heap_Test {

    public init() { }

    public func Heap_Test() {
        // Use priorityFunction ">" for maxHeap, "<" for min Heap
        var heap = Heap(elements: [3, 2, 8, 5, 0], priorityFunction: >)
        print("Heap: \(heap.elements)")
    }
}
