import Foundation

public class AVLTree_Test {
    
    public init() {}
    
    public func avlTree_Test() {
        
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
    }
}
