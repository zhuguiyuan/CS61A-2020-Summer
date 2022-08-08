def generate_subsets():
    """
    >>> subsets = generate_subsets()
    >>> for _ in range(3):
    ...     print(next(subsets))
    ...
    [[]]
    [[], [1]]
    [[], [1], [2], [1, 2]]
    """
    def helper(lst):
        if len(lst) == 0:
            return [[]]
        without_last = helper(lst[:-1])
        with_first = [ls + [lst[-1]] for ls in without_last]
        return without_last + with_first

    num = 0
    while True:
        yield helper(list(range(1, num+1)))
        num += 1
