# game.py
import os
import random
from player import Player
from computer import Computer

class Game:
    ascii_art = {
        'rock': '''
        _______
    ---'   ____)
          (_____)
          (_____)
          (____)
    ---.__(___)
    ''',
        'paper': '''
         _______
    ---'    ____)____
               ______)
              _______)
             _______)
    ---.__________)
    ''',
        'scissors': '''
        _______
    ---'   ____)____
              ______)
           __________)
          (____)
    ---.__(___)
    '''
    }

    def __init__(self):
        self.user_score = 0
        self.computer_score = 0

    def clear_screen(self):
        if os.name == 'nt':  # For Windows
            os.system('cls')
        else:  # For macOS and Linux
            os.system('clear')

    def determine_winner(self, user_choice, computer_choice):
        if user_choice == computer_choice:
            return "tie"
        elif (user_choice == 'rock' and computer_choice == 'scissors') or \
             (user_choice == 'paper' and computer_choice == 'rock') or \
             (user_choice == 'scissors' and computer_choice == 'paper'):
            return "user"
        else:
            return "computer"

    def play(self):
        self.clear_screen()
        print("Welcome to Rock, Paper, Scissors!")
        player = Player()
        computer = Computer()
        while True:
            user_choice = player.get_choice()
            computer_choice = computer.get_choice()
            print(f"\nYou chose:\n{self.ascii_art[user_choice]}")
            print(f"Computer chose:\n{self.ascii_art[computer_choice]}")
            result = self.determine_winner(user_choice, computer_choice)

            if result == "user":
                self.user_score += 1
                print("You win!")
            elif result == "computer":
                self.computer_score += 1
                print("Computer wins!")
            else:
                print("It's a tie!")

            print(f"Score: You {self.user_score} - {self.computer_score} Computer")

            play_again = input("Do you want to play again? (yes/no): ").lower()
            if play_again != 'yes':
                break
            self.clear_screen()