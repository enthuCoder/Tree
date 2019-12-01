import Foundation

public class NAryTreeNode<T> {
    
    public var data: T
    public var children = [NAryTreeNode<T>]()
    public weak var parent: NAryTreeNode<T>?
    
    public init(data: T) {
        self.data = data
    }
}

// ==================================================================
// Tree - Add Nodes
// ==================================================================

extension NAryTreeNode {
    
    public func addChild(_ node: NAryTreeNode<T>) {
        children.append(node)
        node.parent = self
    }
}

extension NAryTreeNode: CustomStringConvertible {
    
    public var description: String {
        var s = "\(data)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return s
    }
}

// ==================================================================
// Tree - Search
// ==================================================================
extension NAryTreeNode where T: Equatable {
    public func search(_ value: T) -> NAryTreeNode<T>? {
        if value == self.data {
            return self
        }
        for child in children {
            if let found = child.search(value) {
                return found
            }
        }
        return nil
    }
}

// ==================================================================
// Tree - Traversal
// ==================================================================

extension NAryTreeNode {
    
    public func preOrderTraversal(withRootNode node: NAryTreeNode<T>?) {
        guard let node = node else {
            return
        }
        print("\(node.data)", terminator: " --> ")
        for child in node.children {
            preOrderTraversal(withRootNode: child)
        }
    }

    public func postOrderTraversal(withRootNode node: NAryTreeNode<T>?) {
        guard let node = node else {
            return
        }
        for child in node.children {
            preOrderTraversal(withRootNode: child)
        }
        print("\(node.data)", terminator: " --> ")
    }

}
