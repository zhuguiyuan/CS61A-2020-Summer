def tree(label, branchs=[]):
    return [label, branchs]

def label(t):
    return t[0]

def branchs(t):
    return t[1]

def is_leaf(t):
    return len(branchs(t)) == 0

def sum_paths_gen(t):
    """
    >>> t1 = tree(5)
    >>> next(sum_paths_gen(t1))
    5
    >>> t2 = tree(1, [tree(2, [tree(3), tree(4)]), tree(9)])
    >>> sorted(sum_paths_gen(t2))
    [6, 7, 10]
    """
    if is_leaf(t):
        yield label(t)
    for b in branchs(t):
        for part_sum in sum_paths_gen(b):
            yield label(t) + part_sum
