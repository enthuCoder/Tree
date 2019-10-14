import Foundation

// ==================================================================
// Binary Search Tree Node
// ==================================================================

public class BSTNode<T> {
    
    public var data: T
    public var leftNode: BSTNode?
    public var rightNode: BSTNode?
    
    public init(data: T, leftNode: BSTNode? = nil, rightNode: BSTNode? = nil) {
        self.data = data
        self.leftNode = leftNode
        self.rightNode = leftNode
    }
}

extension BSTNode: Equatable where T: Equatable {
        
    public static func ==(lhs: BSTNode<T>, rhs: BSTNode<T>) -> Bool {
        return lhs.data == rhs.data
    }
}

extension BSTNode: Comparable where T: Comparable {

    public static func <(lhs: BSTNode<T>, rhs: BSTNode<T>) -> Bool {
        return lhs.data < rhs.data
    }
}

extension BSTNode: CustomStringConvertible where T: CustomStringConvertible {

    public var description: String {
        return self.data.description
    }
}
