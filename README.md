# CLIPS Food Recommender

This CLIPS-based application recommends food recipes based on the ingredients available and the user's preferences. It provides suggestions for quick, healthy, and vegan meals.

## Usage

1. Launch the CLIPS environment.
2. Load the `food_recommender.clp` file.
3. Run the program.
4. Follow the prompts to provide information about your meal preferences and ingredient quantities in your fridge.
5. The program will recommend a suitable recipe based on your preferences and available ingredients.

## Recipes

Here are some example recipes and their required ingredients:

- **Scrambled Eggs**: Eggs (2), Butter (100 grams)
- **Tuna Sandwich**: Tuna (1 can), Bread (100 grams)
- **Burgers**: Meat (200 grams), Bread (100 grams)
- **Butter Chicken**: Chicken (200 grams), Butter (100 grams)
- **Salad**: Vegetables (150 grams)

## Templates

- `ingredient`: Represents an ingredient with slots for name, quantity, and unit.
- `user-preferences`: Stores user preferences for quick preparation, healthy meals, and vegan meals.

## Facts

The `init` deffacts section initializes facts for various ingredients, user preferences, and flags to control program flow.

## Functions

- `ask-question`: Prompts the user with a question and ensures valid responses (yes/no/stop).

## Meal Rules

The program includes rules to determine if you can make specific meals based on your available ingredients and preferences. It provides both positive and negative outcomes.

## Main Rules

- `ask-q1`, `ask-q2`, `ask-q3`: Collects user preferences and sets flags to control program flow.
- `start-over`: Allows the user to restart the program after receiving recommendations.

## Notes

- The program assumes that ingredient quantities are stored in the appropriate units (e.g., grams, pieces, cans).
- It provides recommendations for quick, healthy, and vegan meals based on user preferences.
- The program informs you if you don't have enough ingredients to make a particular recipe.

Enjoy your meal planning with the CLIPS Food Recommender!
