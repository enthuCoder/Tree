
import Foundation

// maxheaps: Elements with a higher value represent higher priority
// minheaps: Elements with a lower value represent higher priority
// Doesn't use any Heap Node. Actually uses Array as a store. Elements to the array are added in such a way that Heap structure rules are honoured for each node
struct Heap<T> {
    
    var elements: [T]
    
    // Takes two element and returns true if first has a higher priorty than the second
    let priorityFunction: (T, T) -> Bool
    
    init(elements: [T] = [], priorityFunction: @escaping (T, T) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        buildHeap()
    }
    
    // Concept: Every level of the heap has room for twice as many elements as the level above, that means every level of the heap has one more element than every level above it combined.
    // So the first half of the heap is actually every parent node in the heap
    mutating func buildHeap() {
        for index in (0..<count/2).reversed() {
            shiftDown(elementAtIndex: index)
        }
    }
    
    // Priority Queue Function
    // Adding new element and removing highest priority element
    var isEmpty: Bool {
        return elements.count == 0 ? true : false
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    // Helper function
    
    // Root index is always 0
    func isRoot(_ index: Int) -> Bool {
        return (index == 0)
    }
    
    // Generic formula for left child: (2 * i) + 1 , where i is parent's index
    func leftChildIndex(of index: Int) -> Int {
        return (2 * index) + 1
    }
    
    // Generic formula for right child: (2 * i) + 2 , where i is parent's index
    func rightChildIndex(of index: Int) -> Int {
        return (2 * index) + 2
    }
    
    // Generic formula
    func parentIndex(of index: Int) -> Int {
        return (index - 1)/2
    }
    
    // Which node and its children points to the highest priority element
    func isHigherPriority(at firstIndex: Int, than secondIndex: Int) -> Bool {
        return priorityFunction(elements[firstIndex], elements[secondIndex])
    }
    
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count && isHigherPriority(at: childIndex, than: parentIndex) else {
            return parentIndex
        }
        return childIndex
    }
    
    // Highest of the three, parent, left and right child
    func highestPriorityIndex(for parent: Int) -> Int {
        return highestPriorityIndex(of: highestPriorityIndex(of: parent, and: leftChildIndex(of: parent)), and: rightChildIndex(of: parent))
    }
    
    mutating func swapElement(at firstIndex: Int, with secondIndex: Int) {
        guard firstIndex != secondIndex else {
            return
        }
        elements.swapAt(firstIndex, secondIndex)
    }
}


extension Heap {
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
        shiftUp(elementAtIndex: count - 1)
    }
    
    mutating func shiftUp(elementAtIndex index: Int) {
        let parent = parentIndex(of: index)
        guard !isRoot(index), isHigherPriority(at: index, than: parent) else {
            return
        }
        swapElement(at: index, with: parent)
        shiftUp(elementAtIndex: parent)
    }
}


extension Heap {
    
    mutating func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }
        swapElement(at: 0, with: count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            shiftDown(elementAtIndex: 0)
        }
        return element
    }
    
    mutating func shiftDown(elementAtIndex index: Int) {
        let childIndex = highestPriorityIndex(for: index)
        if index == childIndex {
            return
        }
        swapElement(at: index, with: childIndex)
        shiftDown(elementAtIndex: childIndex)
    }
}
