# computer.py
import random

class Computer:
    def get_choice(self):
        choices = ['rock', 'paper', 'scissors']
        return random.choice(choices)