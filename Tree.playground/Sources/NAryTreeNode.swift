import Foundation

public class NAryTreeNode<T> {
    
    public var data: T
    public var children: [NAryTreeNode?]?
    
    public init(data: T, children: [NAryTreeNode?]? = nil) {
        self.data = data
        self.children = children
    }
}

//extension BSTNode: Equatable where T: Equatable {
//        
//    public static func ==(lhs: BSTNode<T>, rhs: BSTNode<T>) -> Bool {
//        return lhs.data == rhs.data
//    }
//}
//
//extension BSTNode: Comparable where T: Comparable {
//
//    public static func <(lhs: BSTNode<T>, rhs: BSTNode<T>) -> Bool {
//        return lhs.data < rhs.data
//    }
//}
