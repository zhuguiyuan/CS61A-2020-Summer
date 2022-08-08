def sculptural(ruler, k):
    """
    Given a number `ruler`, finds the largest number of length `k` or fewer,
    composed of digits from `ruler`, in order.
    
    >>> sculptural(1234, 1)
    4
    >>> sculptural(32749, 2)
    79
    >>> sculptural(1917, 2)
    97
    >>> sculptural(32749, 18)
    32749
    """
    if ruler == 0 or k == 0:
        return 0
    a = sculptural(ruler // 10, k - 1) * 10 + ruler % 10
    b = sculptural(ruler // 10, k)
    return max(a, b)
