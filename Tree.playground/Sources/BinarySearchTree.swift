import Foundation

// ==================================================================
// Binary Search Tree
// Rules:
// a) All nodes in the left subtree must have lesser value than the value in the root node.
// b) All node in the right subtree must have greater value than the value in the root node
// c) Left and Right subtrees of root node should follow the above rules recursively
// ==================================================================
public class BinarySearchTree<T: Comparable & CustomStringConvertible> {
    
    public var rootNode: BSTNode<T>?
    
    public init() {}
}

// ==================================================================
// Binary Search Tree - Helper Functions
// ==================================================================
extension BinarySearchTree {
    
    public func isLeaf(node: BSTNode<T>?) -> Bool {
        if node?.leftNode == nil && node?.rightNode == nil {
            return true
        } else {
            return false
        }
    }
}

// ==================================================================
// Binary Search Tree - Add Node
// ==================================================================
extension BinarySearchTree {
    
    public func addNode(_ value: T) {
        let newNode = BSTNode.init(data: value)
        guard let root = self.rootNode else {
            self.rootNode = newNode
            return
        }
        insert(node: newNode, withRootNode: root)
    }
    
    private func insert(node newNode: BSTNode<T>, withRootNode root: BSTNode<T>) {
        // Check if new node needs to go to left or right sub-tree
        if newNode.data <= root.data { // Insert at left subtree
            if let leftNode = root.leftNode {
                insert(node: newNode, withRootNode: leftNode)
            } else {
                root.leftNode = newNode
            }
        } else { // Insert at right sub-tree
            if let rightNode = root.rightNode {
                insert(node: newNode, withRootNode: rightNode)
            } else {
                root.rightNode = newNode
            }
        }
    }
}

// ==================================================================
// Binary Search Tree - Traversal
// ==================================================================
extension BinarySearchTree {
    
    public func inOrderTraversal(withRootNode node: BSTNode<T>?) {
        guard let node = node else {
            return
        }
        self.inOrderTraversal(withRootNode: node.leftNode)
        print("\(node.data)", terminator: " --> ")
        self.inOrderTraversal(withRootNode: node.rightNode)
    }
    
    public func preOrderTraversal(withRootNode node: BSTNode<T>?) {
        guard let node = node else {
            return
        }
        print("\(node.data)", terminator: " --> ")
        self.preOrderTraversal(withRootNode: node.leftNode)
        self.preOrderTraversal(withRootNode: node.rightNode)
    }

    public func postOrderTraversal(withRootNode node: BSTNode<T>?) {
        guard let node = node else {
            return
        }
        self.postOrderTraversal(withRootNode: node.leftNode)
        self.postOrderTraversal(withRootNode: node.rightNode)
        print("\(node.data)", terminator: " --> ")
    }

    public func levelOrderTraversal(withRootNode node: BSTNode<T>?) {
        
    }
}

// =========================
// Find MIN and MAX nodes
//
// Used during Node Deletion
// =========================
extension BinarySearchTree {
    
    // Extreme left node will have minimum value
    public func minNode(_ inputNode: BSTNode<T>?) -> BSTNode<T>? {
        var node = inputNode
        while let next = node?.leftNode {
            node = next
        }
        return node
    }
    
    // Extreme right node will have maximum value
    public func maxNode(_ inputNode: BSTNode<T>?) -> BSTNode<T>? {
        var node = inputNode
        while let next = node?.rightNode {
            node = next
        }
        return node
    }
}

// ============================
// Height or maxDepth of a Node
// ============================
extension BinarySearchTree {
    
    public func maxDepth(ofNode node: BSTNode<T>?) -> Int {
        if isLeaf(node: node) {
            return 0
        }
        return max(maxDepth(ofNode: node?.leftNode), maxDepth(ofNode: node?.rightNode)) + 1
    }
}

// ==================================================================
// Binary Search Tree - Searching a value
// ==================================================================

extension BinarySearchTree {
    
    public func search(_ value: T) {
        self.search(self.rootNode, value)
    }
    
    // Do POST-ORDER traversal for SEARCHING
    private func search(_ root: BSTNode<T>?, _ value: T) {
        guard  let rootNode = root else {
            print("Node is NOT AVAILABLE: \(value)")
            return
        }
        print("Current Root node: \(rootNode.data)")
        if rootNode.data < value {
            self.search(rootNode.rightNode, value)
        } else if rootNode.data > value {
            self.search(rootNode.leftNode, value)
        } else {
            print("Node value AVAILABLE: \(rootNode.data)")
        }
    }
}

// ==================================================================
// Binary Search Tree - Delete a node
//
// Case 1: The element to be deleted is a leaf node. (A node with no children)
//      - navigate to the node and delete it
// Case 2: Node that is to be deleted has one child
//      - similar to node deletion in a linkedList
//      - The child’s connection is first made with the parent of the node to be deleted and then the node is deleted
// Case 3: Node to be deleted has two children
//      - Find:
//          - Smallest value in the right subtree, or
//          - Largest value in the left subtree (We may choose this when there is no right subtree present)
//      - Now swap the values of the resultant node and the node to be deleted
//      - Look at the tree, if the structure and situation are either of the two cases, case 1 and case 2 respectively
//          - According to the found case, proceed
// ==================================================================

extension BinarySearchTree {
    
    public func deleteKey(_ value: T) {
        self.rootNode = self.deleteRecursive(self.rootNode, value)
    }
    
    private func deleteRecursive(_ root: BSTNode<T>?, _ value: T) -> BSTNode<T>? {
        if root == nil {
            return root
        }
    
        if value > (root?.data)! {
            root?.rightNode = deleteRecursive(root?.rightNode, value)
        } else if value < (root?.data)! {
            root?.leftNode = deleteRecursive(root?.leftNode, value)
        } else {
            if root?.leftNode == nil {
                return root?.rightNode
            } else if root?.rightNode == nil {
                return root?.leftNode
            }
    
            root?.data = (minNode(root?.rightNode)!).data
            root?.rightNode = deleteRecursive(root?.rightNode, (root?.data)!)
        }
        return root
    }
}

// ==================================================================
// Binary Search Tree - Check if it is BST
// Approach 1: In-Order Traversal of a BST is in ascending order. Use this property to check if it is a BST
// Approach 2: https://www.youtube.com/watch?v=MILxfAbIhrE
//          Below implementation is using Approach 2
// ==================================================================
extension BinarySearchTree {
    
    public func isValidBST(_ root: BSTNode<T>?) -> Bool {
        
        let isBST: Bool = isBinarySearchTree(withRootNode: root, min: Int.min, max: Int.max)
        return isBST
    }
    
    public func isBinarySearchTree(withRootNode node: BSTNode<T>?, min: Int, max: Int) -> Bool {
        if node == nil {
            return true
        }
        if (node!.data as! Int) < min || (node!.data as! Int) > max || (node!.data as! Int) == min || (node!.data as! Int) == max {
            return false
        }
        return isBinarySearchTree(withRootNode: node!.leftNode, min: min, max: (node!.data as! Int)) && isBinarySearchTree(withRootNode: node!.rightNode, min: (node!.data as! Int), max: max)
    }

}

// ==================================================================
// Binary Search Tree - Print the tree
// ==================================================================
extension BinarySearchTree {
    
    public func printBST() -> String {
        guard let root = self.rootNode else {
            return "Empty Tree!!\n"
        }
        
        return printTree(root) { ($0.data, $0.leftNode, $0.rightNode) }
    }
    
    // SOURCE: https://stackoverflow.com/questions/43898440/how-to-draw-a-binary-tree-in-console
    // TBD: To understand the code and see if it is generic
    public func printTree<T>(_ node: BSTNode<T>, reversed: Bool = false, isTop: Bool = true, using nodeInfo: (BSTNode<T>) -> (T, BSTNode<T>?, BSTNode<T>?)) -> String {
        // node value and sub nodes
        let (val, leftNode, rightNode) = nodeInfo(node)
        
        let valueWidth = "\(val)".count
        
        // recurse to sub nodes to obtain line blocks on left and right
        let leftBlock = leftNode == nil ? [] : printTree(leftNode!, reversed: reversed, isTop: false, using: nodeInfo).components(separatedBy: "\n")
        
        let rightBlock = rightNode == nil ? [] : printTree(rightNode!, reversed: reversed, isTop: false, using: nodeInfo).components(separatedBy: "\n")

        // count common and maximum number of sub node lines
        let commonLines = min(leftBlock.count, rightBlock.count)
        let subLevelLines = max(leftBlock.count, rightBlock.count)
        
        // extend lines on shallower side to get same number of lines on both sides
        let leftSubLines      = leftBlock
                              + Array(repeating:"", count: subLevelLines-leftBlock.count)
        let rightSubLines     = rightBlock
                              + Array(repeating:"", count: subLevelLines-rightBlock.count)

        // compute location of value or link bar for all left and right sub nodes
        //   * left node's value ends at line's width
        //   * right node's value starts after initial spaces
        let leftLineWidths    = leftSubLines.map{$0.count}
        let rightLineIndents  = rightSubLines.map{$0.prefix{$0==" "}.count  }

        // top line value locations, will be used to determine position of current node & link bars
        let firstLeftWidth    = leftLineWidths.first   ?? 0
        let firstRightIndent  = rightLineIndents.first ?? 0

        // width of sub node link under node value (i.e. with slashes if any)
        // aims to center link bars under the value if value is wide enough
        //
        // ValueLine:    v     vv    vvvvvv   vvvvv
        // LinkLine:    / \   /  \    /  \     / \
        //
        let linkSpacing       = min(valueWidth, 2 - valueWidth % 2)
        let leftLinkBar       = leftNode  == nil ? 0 : 1
        let rightLinkBar      = rightNode == nil ? 0 : 1
        let minLinkWidth      = leftLinkBar + linkSpacing + rightLinkBar
        let valueOffset       = (valueWidth - linkSpacing) / 2

        // find optimal position for right side top node
        //   * must allow room for link bars above and between left and right top nodes
        //   * must not overlap lower level nodes on any given line (allow gap of minSpacing)
        //   * can be offset to the left if lower subNodes of right node
        //     have no overlap with subNodes of left node
        let minSpacing        = 2
        let rightNodePosition = zip(leftLineWidths,rightLineIndents[0..<commonLines])
                                .reduce(firstLeftWidth + minLinkWidth)
                                { max($0, $1.0 + minSpacing + firstRightIndent - $1.1) }

        // extend basic link bars (slashes) with underlines to reach left and right
        // top nodes.
        //
        //        vvvvv
        //       __/ \__
        //      L       R
        //
        let linkExtraWidth    = max(0, rightNodePosition - firstLeftWidth - minLinkWidth )
        let rightLinkExtra    = linkExtraWidth / 2
        let leftLinkExtra     = linkExtraWidth - rightLinkExtra

        // build value line taking into account left indent and link bar extension (on left side)
        let valueIndent       = max(0, firstLeftWidth + leftLinkExtra + leftLinkBar - valueOffset)
        let valueLine         = String(repeating:" ", count:max(0,valueIndent))
                              + "\(val)"
        let slash             = reversed ? "\\" : "/"
        let backSlash         = reversed ? "/"  : "\\"
        let uLine             = reversed ? "¯"  : "_"
        // build left side of link line
        let leftLink          = leftNode == nil ? ""
                              : String(repeating: " ", count:firstLeftWidth)
                              + String(repeating: uLine, count:leftLinkExtra)
                              + slash

        // build right side of link line (includes blank spaces under top node value)
        let rightLinkOffset   = linkSpacing + valueOffset * (1 - leftLinkBar)
        let rightLink         = rightNode == nil ? ""
                              : String(repeating:  " ", count:rightLinkOffset)
                              + backSlash
                              + String(repeating:  uLine, count:rightLinkExtra)

        // full link line (will be empty if there are no sub nodes)
        let linkLine          = leftLink + rightLink

        // will need to offset left side lines if right side sub nodes extend beyond left margin
        // can happen if left subtree is shorter (in height) than right side subtree
        let leftIndentWidth   = max(0,firstRightIndent - rightNodePosition)
        let leftIndent        = String(repeating:" ", count:leftIndentWidth)
        let indentedLeftLines = leftSubLines.map{ $0.isEmpty ? $0 : (leftIndent + $0) }

        // compute distance between left and right sublines based on their value position
        // can be negative if leading spaces need to be removed from right side
        let mergeOffsets      = indentedLeftLines
                                .map{$0.count}
                                .map{leftIndentWidth + rightNodePosition - firstRightIndent - $0 }
                                .enumerated()
                                .map{ rightSubLines[$0].isEmpty ? 0  : $1 }

        // combine left and right lines using computed offsets
        //   * indented left sub lines
        //   * spaces between left and right lines
        //   * right sub line with extra leading blanks removed.
        let mergedSubLines    = zip(mergeOffsets.enumerated(),indentedLeftLines)
                                .map{ ( $0.0, $0.1, $1 + String(repeating:" ", count:max(0,$0.1)) ) }
                                .map{ $2 + String(rightSubLines[$0].dropFirst(max(0,-$1))) }

        // Assemble final result combining
        //  * node value string
        //  * link line (if any)
        //  * merged lines from left and right sub trees (if any)
        let treeLines = [leftIndent + valueLine]
                      + (linkLine.isEmpty ? [] : [leftIndent + linkLine])
                      + mergedSubLines

        return (reversed && isTop ? treeLines.reversed(): treeLines)
        .joined(separator:"\n")
    }
}
