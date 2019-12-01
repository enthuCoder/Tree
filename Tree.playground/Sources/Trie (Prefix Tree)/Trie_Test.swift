import Foundation

public class Trie_Test {
    
    public init() { }

    public func Trie_Test() {
        let trie = Trie()
        trie.insert(word: "Cute")
        //print("Trie: \(trie.root.description)")
        print("Trie has Cute: \(trie.contains(word: "Cute"))")
    }
}
