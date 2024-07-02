### ANGELA BAKAJ
### BTC1855 ASSIGNMENT 3

# Read the word list from the file
# User: setwd!!!
# sw message: !!!
dictionary <- suppressWarnings(readLines("dictionary.txt"))

# Selecting a random word from the dictionary:
secret_word <- sample(dictionary, 1)

# Specifying the number of characters that the secret word contains:
secret_word_length <- nchar(secret_word) 

cat("The secret word has", secret_word_length, "letters.\n")

# Initializing the number of attempts the user has:
max_attempts <- 6
cat("You have", max_attempts, "wrong attempts allowed.\n")

# Checking if the input is a single letter:
# Setting this check as a function itself:
is_valid_input <- function(input) {
  return(grepl("^[a-zA-Z]$", input))
}

# Setting up the game variables:
# Ensuring the specify the number of attempts:
attempts <- 0
correct_guesses <- rep("_", secret_word_length)
incorrect_guesses <- character()

while (attempts < max_attempts) {
  cat("Current word: ", paste(correct_guesses, collapse = " "), "\n")
  guess <- tolower(readline(prompt = "Enter a letter: "))
  
  if (!is_valid_input(guess)) {
    cat("Invalid input. Please enter a single letter.\n")
    next
  }
  
  if (guess %in% correct_guesses || guess %in% incorrect_guesses) {
    cat("You have already guessed that letter.\n")
    next
  }
  
  if (grepl(guess, secret_word)) {
    cat("Correct guess!\n")
    positions <- which(strsplit(secret_word, "")[[1]] == guess)
    correct_guesses[positions] <- guess
  } else {
    cat("Wrong guess.\n")
    incorrect_guesses <- c(incorrect_guesses, guess)
    attempts <- attempts + 1
  }
  
  if (all(correct_guesses != "_")) {
    cat("Congratulations! You've guessed the word:", secret_word, "\n")
    break
  }
  
  cat("incorrect guesses:", paste(wrong_guesses, collapse = " "), "\n")
  cat("Remaining tries:", max_attempts - attempts, "\n")
}

if (tries == max_attempts) {
  cat("You've exhausted your attempts. The secret word was:", secret_word, "\n")
}

