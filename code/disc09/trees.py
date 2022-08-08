class Tree:
    def __init__(self, label, branches=[]):
        for b in branches:
            assert isinstance(b, Tree)
        self.label = label
        self.branches = branches
    
    def __repr__(self):
        if self.is_leaf():
            return f'Tree({repr(self.label)})'
        else:
            return f'Tree({repr(self.label)}, [{", ".join(repr(b) for b in self.branches)}])'
    
    def is_leaf(self):
        return not self.branches

def make_even(t):
    """
    >>> t = Tree(1, [Tree(2, [Tree(3)]), Tree(4), Tree(5)])
    >>> make_even(t)
    >>> t.label
    2
    >>> t.branches[0].branches[0].label
    4
    """
    if t.label % 2 == 1:
        t.label += 1
    for b in t.branches:
        make_even(b)

def square_tree(t):
    """Mutates a Tree t by squareing all its elements.

    >>> t = Tree(1, [Tree(2, [Tree(3)]), Tree(4), Tree(5)])
    >>> square_tree(t)
    >>> t.label
    1
    >>> t.branches[0].label
    4
    >>> t.branches[1].label
    16
    >>> t.branches[2].label
    25
    >>> t.branches[0].branches[0].label
    9
    """
    t.label **= 2
    for b in t.branches:
        square_tree(b)

def find_path(t, entry):
    """
    Find a path from t to the node whose label is entry.
    Assume that the elements in t are unique.
    if entry is not in t, return False.

    >>> tree_ex = Tree(2, [Tree(7, [Tree(3), Tree(6, [Tree(5), Tree(11)])]), Tree(1)])
    >>> find_path(tree_ex, 5)
    [2, 7, 6, 5]
    >>> find_path(tree_ex, 13)
    False
    """
    if t.label == entry:
        return [t.label]
    for b in t.branches:
        path = find_path(b, entry)
        if path:
            return [t.label] + path
    return False

def average(t):
    """
    Returns the average value of all the nodes in t.
    >>> t0 = Tree(0, [Tree(1), Tree(2, [Tree(3)])])
    >>> average(t0)
    1.5
    >>> t1 = Tree(8, [t0, Tree(4)])
    >>> average(t1)
    3.0
    """
    def sum_helper(t):
        total, count = t.label, 1
        for b in t.branches:
            sub_total, sub_count = sum_helper(b)
            total += sub_total
            count += sub_count
        return total, count
    total, count = sum_helper(t)
    return total / count

def combine_tree(t1, t2, combiner):
    """
    >>> from operator import mul
    >>> a = Tree(1, [Tree(2, [Tree(3)])])
    >>> b = Tree(4, [Tree(5, [Tree(6)])])
    >>> combined = combine_tree(a, b, mul)
    >>> combined.label
    4
    >>> combined.branches[0].label
    10
    """
    new_label = combiner(t1.label, t2.label)
    new_branches = [combine_tree(b1, b2, combiner)
                    for b1, b2 in zip(t1.branches, t2.branches)]
    return Tree(new_label, new_branches)

def alt_tree_map(t, map_fn):
    """
    >>> t = Tree(1, [Tree(2, [Tree(3)]), Tree(4)])
    >>> negate = lambda x: -x
    >>> alt_tree_map(t, negate)
    Tree(-1, [Tree(2, [Tree(-3)]), Tree(4)])
    """
    def helper(t, map_fn):
        new_branches = [alt_tree_map(b, map_fn) for b in t.branches]
        return Tree(t.label, new_branches)
    new_label = map_fn(t.label)
    new_branches = [helper(b, map_fn) for b in t.branches]
    return Tree(new_label, new_branches)