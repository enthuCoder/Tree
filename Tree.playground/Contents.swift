import Cocoa

let numberList: Array<Int> = [11, 2, 13, 1, 9, 57, 3, 25, 90, 17]
var root = BinarySearchTree<Int>()
for number in numberList {
    root.addNode(number)
}
print("\(root.printBST())")

print("Min Node: \(String(describing: root.minNode()))")
print("Max Node: \(String(describing: root.maxNode()))")

print("\nIn-Order Traversal: ")
root.inOrderTraversal(withRootNode: root.rootNode)

print("\n\nPre-Order Traversal: ")
root.preOrderTraversal(withRootNode: root.rootNode)

print("\n\nPost-Order Traversal: ")
root.postOrderTraversal(withRootNode: root.rootNode)
