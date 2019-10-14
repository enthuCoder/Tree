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

}

// =========================
// Find MIN and MAX nodes
//
// Used during Node Deletion
// =========================
extension BinarySearchTree {
    
    // Extreme left node will have minimum value
    public func minNode() -> BSTNode<T>? {
        var node = self.rootNode
        while let next = node?.leftNode {
            node = next
        }
        return node
    }
    
    // Extreme right node will have maximum value
    public func maxNode() -> BSTNode<T>? {
        var node = self.rootNode
        while let next = node?.rightNode {
            node = next
        }
        return node
    }
}

// ==================================================================
// Binary Search Tree - Searching a value
// ==================================================================

// ==================================================================
// Binary Search Tree - Delete a node - TBD
// ==================================================================

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
