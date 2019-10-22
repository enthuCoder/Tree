import Cocoa

let numberList: Array<Int> = [11, 2, 13, 1, 9, 57, 3, 25, 90, 17, 26, 95]
var root = BinarySearchTree<Int>()

// ==================
// Add Nodes to a BST
// ==================

for number in numberList {
    root.addNode(number)
}
// ==================
// Print a BST
// ==================
print("\(root.printBST())")

print("Min Node: \(String(describing: root.minNode(root.rootNode)))")
print("Max Node: \(String(describing: root.maxNode(root.rootNode)))")

// ==============
// Tree Traversal
// ==============
print("\nIn-Order Traversal: ")
root.inOrderTraversal(withRootNode: root.rootNode)

print("\n\nPre-Order Traversal: ")
root.preOrderTraversal(withRootNode: root.rootNode)

print("\n\nPost-Order Traversal: ")
root.postOrderTraversal(withRootNode: root.rootNode)

// ==============
// Tree Searching
// ==============
let searchData = 17
print("Search Node with data value \(searchData):")
root.search(searchData)

// =======================
// Delete nodes from a BST
// =======================
print("\nBST before node delete:\n \(root.printBST())")
let deleteNodeData = 11
print("\nDelete node \(deleteNodeData):")
root.deleteKey(deleteNodeData)
print("Updated tree:")
print("\(root.printBST())")

// =======================
// Check if a tree is BST
// =======================
print("Is BinarySearchTree: \(root.isValidBST(root.rootNode))")
