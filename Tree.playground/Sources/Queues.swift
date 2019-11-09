import Foundation

// Queue is a FIFO DS
// Enqueuing and Dequeuing happens at different ends
// Enqueue and Dequeue are O(1) operations

// ------------------------------------------------------------
// MARK: Implement Queue using an Array as the base storage
// ------------------------------------------------------------

public struct Queue<T: Comparable & CustomStringConvertible> {

    public var storage = [T]()
    
    public init() { }
}

// ------------------------------------------------------------
// MARK: Implement Queue Helper functions
// ------------------------------------------------------------

extension Queue {
    
    public var count: Int {
        return storage.count
    }
    
    public var isEmpty: Bool {
        return storage.isEmpty
    }
    
    public func front() -> T? {
        return storage.first
    }
    
    public func last() -> T? {
        return storage.last
    }
    
    public mutating func enqueue(_ newValue: T) {
        storage.append(newValue)
    }
    
    public mutating func dequeue() -> T? {
        guard let _ = storage.first else {
            print("Queue is empty")
            return nil
        }
        return storage.removeFirst()
    }
}

// ------------------------------------------------------------
// MARK: Queue representation
// ------------------------------------------------------------
extension Queue {
    
    public var description: String {
        let top = "### QUEUE ###\n\n"
        let bottom = "\n\n##############\n"
        let element = self.storage.map {$0.description}.joined(separator: " ")
        return top + element + bottom
    }
}
