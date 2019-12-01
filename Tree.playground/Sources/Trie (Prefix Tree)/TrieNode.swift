import Foundation

// Using Dictionary implementation

// T needs to conform to Hashable protocol, as it will be used as a key in children Dictionary
public class TrieNode<T: Hashable> {
    
    public var value: T?
    public weak var parent: TrieNode<T>?
    public var children: [T: TrieNode<T>] = [:]
    public var isTerminating: Bool
    public var isLeaf: Bool {
        return children.count == 0
    }
    
    public init(value: T? = nil, parent: TrieNode? = nil, isTerminating: Bool = false) {
        self.value = value
        self.parent = parent
        self.isTerminating = isTerminating
    }

    public func add(child: T) {
        
        // Make sure child already doesn't exist in the dictionary of Children
        guard children[child] == nil else {
            return
        }
        
        // Create a new node for the new value. Add the new node to the children dictionary of the current node
        children[child] = TrieNode(value: child, parent: self)
    }
}

//extension TrieNode<T>: CustomStringConvertible {
//
////    public var description: String {
////        var s = "\(value)"
////        if !children.isEmpty {
////            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
////        }
////        return s
////    }
////}

