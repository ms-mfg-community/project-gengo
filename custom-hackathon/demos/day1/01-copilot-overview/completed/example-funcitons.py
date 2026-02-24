# Example 1: Generate a utility function with docstring to validate email addresses
def is_valid_email(email):
    """
    Validate if the provided string is a valid email address.

    Args:
        email (str): The email address to validate.
    Returns:
        bool: True if the email address is valid, False otherwise.
    """
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

# Example 2: Create a function to calculate factorial of a number
def factorial(n):
    """
    Calculate the factorial of a non-negative integer.

    Args:
        n (int): A non-negative integer.
    Returns:
        int: The factorial of the given integer.
    Raises:
        ValueError: If n is negative.
    """
    if n < 0:
        raise ValueError("Factorial is not defined for negative numbers.")
    if n == 0 or n == 1:
        return 1
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result
# Add a main function with header and test both functions using an array of test cases
def main():
    # Test cases for is_valid_email function
    email_tests = [
        "test@example.com",
        "invalid-email",
        "user@domain.co",
        "user.name@domain.com",
        "user@sub.domain.com"
    ]
    for email in email_tests:
        print(f"Is '{email}' a valid email? {is_valid_email(email)}")

    # Test cases for factorial function
    factorial_tests = [
        0,
        1,
        5,
        10
    ]
    for n in factorial_tests:
        try:
            print(f"Factorial of {n}: {factorial(n)}")
        except ValueError as e:
            print(e)
if __name__ == "__main__":
    main()
    