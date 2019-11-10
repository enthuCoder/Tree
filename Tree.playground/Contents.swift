import Cocoa


// =========================================
// ********** BINARY SEARCH TREE **********
// =========================================

print("\n // =========================================")
print("    ********** BINARY SEARCH TREE ********** ")
print(" // =========================================\n")

let numberList: Array<Int> = [10,5,15,3,7,18] //[11, 2, 13, 1, 9, 57, 3, 25, 90, 17, 26, 95]
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
print("BST 1:\n \(root.printBST())\n")

let newList = [10,5,15,3,7,13,18,1,6]
var rootNew = BinarySearchTree<Int>()
for number in newList {
    rootNew.addNode(number)
}
print("BST 2:\n \(rootNew.printBST())\n")

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

print("\n\nLevel-Order OR BFS Traversal: ")
rootNew.levelOrderTraversal(withRootNode: rootNew.rootNode)

// ==============
// Tree Searching
// ==============
let searchData = 17
print("Search Node with data value \(searchData):")
root.search(searchData)

let searchData2 = 5
print("Search Node with data value \(searchData2):")
let searchedNode = root.search(searchData2)
if let node = searchedNode {
    print("Found Node \(node)")
}
print("\(root.printBST(withRoot: searchedNode))")

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

// =======================
// Height of a BST
// =======================
var resultNode = root.rootNode
if let node = resultNode {
    print("HEIGHT or maxDepth of \(String(describing: node.data)) Node: \(root.maxDepth(ofNode: resultNode))")
}
resultNode = root.rootNode?.rightNode?.rightNode
if let node = resultNode {
    print("HEIGHT or maxDepth of \(String(describing: node.data)) Node: \(root.maxDepth(ofNode: resultNode))")
}








// =========================================
// ********** AVL TREE **********
// =========================================
print("\n // =========================================")
print("        ********** AVL TREE ********** ")
print(" // =========================================\n")
let numberListForAVL: Array<Int> = [5, 4, 3, 2, 1]
var avlTree = AVLTree<Int>()

// ==================
// Add Nodes to a AVL Tree
// ==================

for number in numberListForAVL {
    avlTree.addNode(number)
    
    // Check if the tree is balanced. If yes, continue adding next element
//    print("AVL Tree after adding \(number) Ndoe: \(avlTree.printAVLTree())")
    if avlTree.rootNode?.balanced == true {
        print("The Tree is balanced, no need to Balance it again")
        continue
    } else { // If not, Balance AVLTree. Check if Balanced, then proceed to adding next element
        
    }
    
}

print("AVL Tree: \(avlTree.printAVLTree())")
