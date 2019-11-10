import Foundation

public class NAryTree<T> {

    public var rootNode: NAryTreeNode<T>?
    public init() {}

}

// ==================================================================
// Binary Search Tree - Add Node
// ==================================================================
extension NAryTree {
    
    public func addNode(_ value: T) {
        let newNode = NAryTreeNode.init(data: value)
        guard let root = self.rootNode else {
            self.rootNode = newNode
            return
        }
        insert(node: newNode, withRootNode: root)
    }
    
    private func insert(node newNode: NAryTreeNode<T>, withRootNode root: NAryTreeNode<T>) {
        // Check if new node needs to go to left or right sub-tree
//        if newNode.data <= root.data { // Insert at left subtree
//            if let leftNode = root.leftNode {
//                insert(node: newNode, withRootNode: leftNode)
//            } else {
//                root.leftNode = newNode
//            }
//        } else { // Insert at right sub-tree
//            if let rightNode = root.rightNode {
//                insert(node: newNode, withRootNode: rightNode)
//            } else {
//                root.rightNode = newNode
//            }
//        }
    }
}
