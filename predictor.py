import random

class CryptoPredictor:
    def __init__(self):
        self.trend = 0  # Initial trend (-1 down, 0 neutral, 1 up)

    def predict_next(self):
        """
        Simple prediction logic:
        Randomly decides if crypto goes up or down
        Trend can slightly affect probability
        """
        probabilities = [0.45, 0.45]  # down, up
        if self.trend == 1:  # if previous was up
            probabilities = [0.4, 0.6]
        elif self.trend == -1:  # if previous was down
            probabilities = [0.6, 0.4]

        move = random.choices([-1, 1], weights=probabilities)[0]
        self.trend = move
        return move
