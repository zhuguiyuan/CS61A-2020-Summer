def get_one_digit(number):
    """Return the one digit of a number.
    
    >>> get_one_digit(0)
    0
    >>> get_one_digit(11)
    1
    >>> get_one_digit(999)
    9
    """
    assert type(number) == int , 'number must be an int.'
    assert number >= 0 , 'number must be more than zero.'
    
    return number % 10

def get_tens_digit(number):
    """Return the tens digit of a number.
    
    When number is less than ten, return zero.
    >>> get_tens_digit(5)
    0
    >>> get_tens_digit(11)
    1
    >>> get_tens_digit(999)
    9
    """
    assert type(number) == int , 'number must be an int.'
    assert number >= 0 , 'number must be more than zero.'
    
    return number // 10 % 10