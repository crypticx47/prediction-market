from predictor import CryptoPredictor

def main():
    predictor = CryptoPredictor()
    print("Welcome to Mini Crypto Prediction Game!")
    print("Try to guess if the crypto price goes UP or DOWN.")

    score = 0
    rounds = 5  # Number of prediction rounds

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
