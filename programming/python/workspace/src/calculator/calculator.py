import math

def clear_screen():
    print("\033[H\033[J", end="")

def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b == 0:
        raise ZeroDivisionError("Cannot divide by zero.")
    return a / b

def modulo(a, b):
    return a % b

def exponent(a, b):
    return math.pow(a, b)

def main():
    continue_calculation = True

    while continue_calculation:
        clear_screen()

        try:
            first_number = float(input("Enter the first number: "))
        except ValueError:
            print("Invalid input. Please enter a valid number.")
            continue

        try:
            second_number = float(input("Enter the second number: "))
        except ValueError:
            print("Invalid input. Please enter a valid number.")
            continue

        operation = input("Enter the operator (+, -, *, /, %, ^): ")

        try:
            result = {
                "+": add,
                "-": subtract,
                "*": multiply,
                "/": divide,
                "%": modulo,
                "^": exponent
            }[operation](first_number, second_number)
        except KeyError:
            print("Invalid operator. Please enter one of +, -, *, /, %, ^.")
            continue
        except Exception as ex:
            print(ex)
            continue

        print(f"The result is: {result}")

        response = input("Do you want to perform another calculation? (yes/no): ").lower()
        if response != "yes":
            clear_screen()
            continue_calculation = False
            print("Thank you for using the calculator. Goodbye!")

if __name__ == "__main__":
    main()
