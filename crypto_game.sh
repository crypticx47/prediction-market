#!/bin/bash

# -------------------------------
# Project folder
PROJECT_NAME="prediction-market"

# -------------------------------
# Create project folder
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

# -------------------------------
# Create .gitignore
cat > .gitignore <<EOL
__pycache__/
*.pyc
*.log
.env
EOL

# -------------------------------
# Create LICENSE (MIT)
cat > LICENSE <<EOL
MIT License

Copyright (c) 2025 crypticx47

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOL

# -------------------------------
# Create requirements.txt
touch requirements.txt

# -------------------------------
# Create predictor.py
cat > predictor.py <<EOL
import random

class CryptoPredictor:
    def __init__(self):
        self.trend = 0  # Initial trend (-1 down, 0 neutral, 1 up)

    def predict_next(self):
        probabilities = [0.45, 0.45]  # down, up
        if self.trend == 1:
            probabilities = [0.4, 0.6]
        elif self.trend == -1:
            probabilities = [0.6, 0.4]
        move = random.choices([-1, 1], weights=probabilities)[0]
        self.trend = move
        return move
EOL

# -------------------------------
# Create main.py
cat > main.py <<EOL
from predictor import CryptoPredictor

def main():
    predictor = CryptoPredictor()
    print("Welcome to Mini Crypto Prediction Game!")
    print("Try to guess if the crypto price goes UP or DOWN.")

    score = 0
    rounds = 5

    for i in range(rounds):
        user_input = input(f"Round {i+1} - Guess UP or DOWN: ").strip().lower()
        prediction = predictor.predict_next()

        correct = (prediction == 1 and user_input == "up") or \
                  (prediction == -1 and user_input == "down")

        if correct:
            print("Correct prediction! ✅")
            score += 1
        else:
            print("Wrong prediction! ❌")
        print(f"Actual move was: {'UP' if prediction == 1 else 'DOWN'}\n")

    print(f"Game Over! Your score: {score}/{rounds}")

if __name__ == "__main__":
    main()
EOL

# -------------------------------
# Initialize Git repo
git init

# -------------------------------
# Add remote (replace with your repo)
REMOTE="git@github.com:crypticx47/prediction-market.git"
git remote add origin $REMOTE 2>/dev/null

# -------------------------------
# Commit and push
git add .
git commit -m "Initial commit: Mini crypto prediction game"
git push origin main 2>/tmp/push_error.log

if [ $? -ne 0 ]; then
    echo "Push failed. Attempting to pull and force push..."
    git pull origin main --allow-unrelated-histories
    git push origin main --force
fi

echo "Crypto Prediction Game project setup complete!"

