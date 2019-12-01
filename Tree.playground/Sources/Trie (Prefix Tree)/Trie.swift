import Foundation

public class Trie: NSObject {
    public typealias Node = TrieNode<Character>
    public let root: Node
    
    public override init() {
        root = Node()
        wordCount = 0
        super.init()
    }
    
    public var wordCount: Int
    public var isEmpty: Bool {
        return wordCount == 0
    }
    
    public var words: [String] {
        return wordsInSubtrie(rootNode: root, partialWord: "")
    }
}

extension Trie {
    
    public func insert(word: String) {
        guard !word.isEmpty else {
            return
        }
        
        var currNode = self.root
        let characters = Array(word.lowercased())
        var currIndex = 0
        
        while currIndex < characters.count {
            let character = characters[currIndex]
            if let child = currNode.children[character] {
                currNode = child
            } else {
                currNode.add(child: character)
                currNode = currNode.children[character]!
            }
            currIndex += 1
            if currIndex == characters.count {
                currNode.isTerminating = true
            }
        }
    }
}

extension Trie {
    
    public func contains(word: String) -> Bool {
        guard !word.isEmpty else {
            return false
        }

        var currNode = self.root
        let characters = Array(word.lowercased())
        var currIndex = 0
        
        while currIndex < characters.count, let child = currNode.children[characters[currIndex]] {
            currIndex += 1
            currNode = child
        }
        
        if currNode.isTerminating == true && currIndex == characters.count {
            return true
        } else {
            return false
        }
    }
    
    public func findLastNodeOf(word: String) -> Node? {
        var currNode = self.root
        let characters = Array(word.lowercased())
        var currIndex = 0
        
        while currIndex < characters.count, let child = currNode.children[characters[currIndex]] {
            currIndex += 1
            currNode = child
        }
        
        if currIndex == characters.count {
            return currNode
        } else {
            return nil
        }
    }
    
    public func findTerminalNodeOf(word: String) -> Node? {
        if let lastNode = findLastNodeOf(word: word) {
            return lastNode.isTerminating ? lastNode : nil
        }
        return nil
    }
}

extension Trie {
    public func remove(word: String) {
        guard !word.isEmpty else {
            return
        }
        
        guard let terminalNode = findLastNodeOf(word: word) else {
            return
        }
        
        if terminalNode.isTerminating {
            deleteNodesForWordEndingWith(terminalNode: terminalNode)
        } else {
            terminalNode.isTerminating = false
        }
    }
    
    func deleteNodesForWordEndingWith(terminalNode: Node) {
        var lastNode = terminalNode
        var character = lastNode.value
        while lastNode.isTerminating, let parentNode = lastNode.parent {
            lastNode = parentNode
            lastNode.children[character!] = nil
            character = lastNode.value
            if lastNode.isTerminating {
                break
            }
        }
    }
}


extension Trie {
    
    public func wordsInSubtrie(rootNode: Node, partialWord: String) -> [String] {
        var subtrieWords = [String]()
        var previousLetters = partialWord
        
        if let value = rootNode.value {
            previousLetters.append(value)
        }
        if rootNode.isTerminating {
            subtrieWords.append(previousLetters)
        }
        
        for childNode in rootNode.children.values {
            let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
            subtrieWords += childWords
        }
        return subtrieWords
    }
}


