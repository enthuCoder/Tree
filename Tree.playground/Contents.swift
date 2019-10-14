import Cocoa

let numberList: Array<Int> = [11, 2, 13, 1, 9, 57, 3, 25, 90, 17]
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

print("Min Node: \(String(describing: root.minNode()))")
print("Max Node: \(String(describing: root.maxNode()))")

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
let searchData = 19
print("Search Node with data value \(searchData):")
root.search(searchData)

// =======================
// Delete nodes from a BST
// =======================
let deleteNodeData = 17
print("\nDelete node \(deleteNodeData):")
print("Updated tree:")
print("\(root.printBST())")
