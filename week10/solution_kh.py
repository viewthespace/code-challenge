import re

A_VAL = 97

class Node(object):
    def __init__(self, x):
        """A node in a trie"""
        self.value = x
        self.children = [False for _ in range(26)]

    def hasChild(self, x):
        """Checks if this node has x as a child
        x -- a letter to see if this node has fathered
        returns -- Node if that child exists else False if it doesn't
        """
        return self.children[ord(x) - A_VAL]

    def addChild(self, x):
        """Adds x as a child to this node
        x -- value to add as a child
        """
        self.children[ord(x) - A_VAL] = Node(x)

class Trie(object):
    def __init__(self):
        self.root = Node(None)

    def mem(self, w):
        """Returns if this trie contains x
        w -- word to look for in trie
        """
        cur = self.root
        for letter in w:
            status = cur.hasChild(letter)
            if status is False:
                return False
            else:
                cur = status
        return True

    def add(self, w):
        """Adds x to this trie
        w -- word to be added
        """
        pass
        cur = self.root
        for letter in w:
            status = cur.hasChild(letter)
            if status is False:
                cur.addChild(letter)
            else:
                cur = status

trans = ['a','x','j','e','0','u','i','d','c','h','t','n','m','b','r','l','0','p','o','y','g','k','0','q','f','0']

def qtod(word):
    fin = ""
    for letter in word:
        fin += trans[ord(letter) - A_VAL]
    return fin

if __name__ == "__main__":
    t = Trie()
    ws = []
    with open('/usr/share/dict/words') as ch:
        for word in ch:
            word = word.strip().lower()
            if not re.search('[eqwz-]', word):
                t.add(word)
                ws.append(word)
    count = 0
    for word in ws:
        tmp = qtod(word)
        if t.mem(tmp):
            print(tmp, word)
            count += 1
    print("Puns:", count)
