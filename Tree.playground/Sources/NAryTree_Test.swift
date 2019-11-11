import Foundation

public class NAryTree_Test {
    public init() { }
    
    public func nAryTree_Test() {
        
        let tree = NAryTreeNode<String>(data: "beverages")

        let hotNode = NAryTreeNode<String>(data: "hot")
        let coldNode = NAryTreeNode<String>(data: "cold")

        let teaNode = NAryTreeNode<String>(data: "tea")
        let coffeeNode = NAryTreeNode<String>(data: "coffee")
        let chocolateNode = NAryTreeNode<String>(data: "cocoa")

        let blackTeaNode = NAryTreeNode<String>(data: "black")
        let greenTeaNode = NAryTreeNode<String>(data: "green")
        let chaiTeaNode = NAryTreeNode<String>(data: "chai")

        let sodaNode = NAryTreeNode<String>(data: "soda")
        let milkNode = NAryTreeNode<String>(data: "milk")

        let gingerAleNode = NAryTreeNode<String>(data: "ginger ale")
        let bitterLemonNode = NAryTreeNode<String>(data: "bitter lemon")

        tree.addChild(hotNode)
        tree.addChild(coldNode)

        hotNode.addChild(teaNode)
        hotNode.addChild(coffeeNode)
        hotNode.addChild(chocolateNode)

        coldNode.addChild(sodaNode)
        coldNode.addChild(milkNode)

        teaNode.addChild(blackTeaNode)
        teaNode.addChild(greenTeaNode)
        teaNode.addChild(chaiTeaNode)

        sodaNode.addChild(gingerAleNode)
        sodaNode.addChild(bitterLemonNode)

        print("\(tree.description)")

//        teaNode.parent
//        teaNode.parent!.parent

        print("\(String(describing: tree.search("cocoa")))")
        print("\(String(describing: tree.search("chai")))")
        print("\(String(describing: tree.search("bubbly")))")

        print("Post Order Traversal - \n")
        print("\(tree.postOrderTraversal(withRootNode: tree))")
        print("\n")
        print("Pre Order Traversal - \n")
        print("\(tree.preOrderTraversal(withRootNode: tree))\n")
    }
}
