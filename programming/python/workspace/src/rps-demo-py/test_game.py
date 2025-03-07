import unittest
from game import Game

class TestRockPaperScissors(unittest.TestCase):
    def setUp(self):
        self.game = Game()

    def test_rock_vs_rock(self):
        result = self.game.determine_winner('rock', 'rock')
        print(f"User choice: rock, Computer choice: rock, Result: {result}")
        self.assertEqual(result, 'tie')
        self.assertEqual(result, 'tie')

    def test_rock_vs_paper(self):
        result = self.game.determine_winner('rock', 'paper')
        print(f"User choice: rock, Computer choice: paper, Result: {result}")
        self.assertEqual(result, 'computer')
        self.assertEqual(result, 'computer')

    def test_rock_vs_scissors(self):
        result = self.game.determine_winner('rock', 'scissors')
        print(f"User choice: rock, Computer choice: scissors, Result: {result}")
        self.assertEqual(result, 'user')
        self.assertEqual(result, 'user')

    def test_paper_vs_rock(self):
        result = self.game.determine_winner('paper', 'rock')
        print(f"User choice: paper, Computer choice: rock, Result: {result}")
        self.assertEqual(result, 'user')
        self.assertEqual(result, 'user')

    def test_paper_vs_paper(self):
        result = self.game.determine_winner('paper', 'paper')
        print(f"User choice: paper, Computer choice: paper, Result: {result}")
        self.assertEqual(result, 'tie')
        self.assertEqual(result, 'tie')

    def test_paper_vs_scissors(self):
        result = self.game.determine_winner('paper', 'scissors')
        print(f"User choice: paper, Computer choice: scissors, Result: {result}")
        self.assertEqual(result, 'computer')
        self.assertEqual(result, 'computer')

    def test_scissors_vs_rock(self):
        result = self.game.determine_winner('scissors', 'rock')
        print(f"User choice: scissors, Computer choice: rock, Result: {result}")
        self.assertEqual(result, 'computer')
        self.assertEqual(result, 'computer')

    def test_scissors_vs_paper(self):
        result = self.game.determine_winner('scissors', 'paper')
        print(f"User choice: scissors, Computer choice: paper, Result: {result}")
        self.assertEqual(result, 'user')
        self.assertEqual(result, 'user')

    def test_scissors_vs_scissors(self):
        result = self.game.determine_winner('scissors', 'scissors')
        print(f"User choice: scissors, Computer choice: scissors, Result: {result}")
        self.assertEqual(result, 'tie')
        self.assertEqual(result, 'tie')

if __name__ == '__main__':
    unittest.main(verbosity=2)