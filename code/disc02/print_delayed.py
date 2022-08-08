def print_delayed(x):
    """Return a new function. This new function, when called,
    will print out x and return another function with the same
    behavior.
    >>> f = print_delayed(1)
    >>> f = f(2)
    1
    >>> f = f(3)
    2
    >>> f = f(4)(5)
    3
    4
    >>> _ = f("hi")
    5
    """
    def delay_print(y):
        print(x)
        return print_delayed(y)
    return delay_print
