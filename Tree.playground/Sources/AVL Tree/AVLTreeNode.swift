import Foundation

// ==================================================================
// AVL Tree Node
// ==================================================================

public class AVLTreeNode<T: Comparable> {
    
    public typealias NodeType = AVLTreeNode<T>
    
    public var data: T
    public var leftNode: NodeType?
    public var rightNode: NodeType?
    public var parent: NodeType? // to check the ancestor
    
    public init(data: T, leftNode: NodeType? = nil, rightNode: NodeType? = nil, parent: NodeType? = nil) {
        self.data = data
        self.leftNode = leftNode
        self.rightNode = rightNode
        self.parent = parent
        
        self.leftNode?.parent = self
        self.leftNode?.parent = self
    }
    
    public var height: Int = 1
    
    //
    func calculateHeight() {
        self.height = Swift.max(self.leftNode?.height ?? 0, self.rightNode?.height ?? 0) + 1
    }
    
    // Balance Factor of each nodes
    public var balanceFactor: Int {
        return (self.rightNode?.height ?? 0) - (self.leftNode?.height ?? 0)
    }
    
    // Check if current root node is height balanced, &&
    // Left subtree nodes are height balanced
    // Right subtree nodes are height balanced
    public var balanced: Bool {
        return (abs(self.balanceFactor) <= 1) &&
                        (self.leftNode?.balanced ?? true) &&
                                (self.rightNode?.balanced ?? true)
    }
}

// ==================================================================
// AVL Tree: Helper functions
// ==================================================================
extension AVLTreeNode {
    
    public var isRoot: Bool {
        return self.parent == nil
    }
    
    public var isLeaf: Bool {
        return (self.leftNode == nil && self.rightNode == nil)
    }
    
    public var isLeftChild: Bool {
        return self.parent?.leftNode == self
    }
    
    public var isRightChild: Bool {
        return self.parent?.rightNode == self
    }
    
    public var hasAnyChild: Bool {
        return (self.leftNode != nil || self.rightNode != nil)
    }
    
    public var hasBothChildren: Bool {
        return (self.leftNode != nil && self.rightNode != nil)
    }
    
    public func minimum() -> AVLTreeNode<T>? {
        return leftNode?.minimum() ?? self
    }
    
    public func maximum() ->AVLTreeNode<T>? {
        return rightNode?.maximum() ?? self
    }
}

extension AVLTreeNode: Equatable where T: Equatable {
        
    public static func ==(lhs: AVLTreeNode<T>, rhs: AVLTreeNode<T>) -> Bool {
        return lhs.data == rhs.data
    }
}

extension AVLTreeNode: Comparable where T: Comparable {

    public static func <(lhs: AVLTreeNode<T>, rhs: AVLTreeNode<T>) -> Bool {
        return lhs.data < rhs.data
    }
}

extension AVLTreeNode: CustomStringConvertible where T: CustomStringConvertible {

    public var description: String {
        return self.data.description
    }
}

