# player.py
class Player:
    def get_choice(self):
        user_input = input("Enter your choice (rock, paper, scissors): ").lower()
        while user_input not in ['rock', 'paper', 'scissors']:
            user_input = input("Invalid choice. Please enter rock, paper, or scissors: ").lower()
        return user_input