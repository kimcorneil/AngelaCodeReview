### ANGELA BAKAJ
### BTC1855 ASSIGNMENT 3

# Reading the word list from the text file "dictionary.txt"
# User note: Use function setwd() with the specified pathway.
# Below, I am using the "suppressWarnings" function as R detects an issue with the text file by default.
# The "readLines" function is then able to read the dictionary terms needed for hangman into R.
dictionary <- suppressWarnings(readLines("dictionary.txt"))

# Selecting a random word from the dictionary:
# Using the "sample" function to grab a singular term from the dictionary at random.
secret_word <- sample(dictionary, 1)

# Specifying the number of characters that the secret word contains:
# Using the "nchar" function to count the number of characters contained in the secret word.
secret_word_length <- nchar(secret_word) 

# Using the "cat" function to display the message that specifies the number of words in the secret word to the user.
cat("The secret word has", secret_word_length, "letters.\n")

# Initializing the number of attempts the user has:
# In my game, I set the maximum number of attempts to 6; this is most traditional in hangman as the 6 attempts correlate to the head, two arms, body, and two legs of the "hangman". 
max_attempts <- 6
# Using the "cat" function again to display the number of attempts remaining to the user.
cat("You have", max_attempts, "wrong attempts allowed.\n")

# Checking if the input is a single letter:
# Using the "grepl" function to limit the input to only character, both upper and lowercase, from A-Z.
# Setting this check as a function itself using the "function" setting.
is_valid_input <- function(input) {
  return(grepl("^[a-zA-Z]$", input))
}

# Setting up the game variables:
# Ensuring to specify the number of attempts:
attempts <- 0
# Using the "rep" function to replicate the underscores as placeholders for the letters in the secret word.
correct_guesses <- rep("_", secret_word_length)
# Using the "character" function to log/record and display the incorrect letters that the user has guessed.
incorrect_guesses <- character()

# Setting up the game loop, using a "while" loop:
# Ensuring that only while the attempts the user has committed do not exceed the maximum attempts, the following will run
# Using the "cat" function in tandem with "paste" and its accompanying argument "collapse" to display the correct guesses as characters on the secret word, replacing the underscores as they are no longer missing.
# Using the "tolower" function in tandem with "readline" and "prompt" to prompt the user to enter their letter/guess and ensure it remains lowercase.
while (attempts < max_attempts) {
  cat("Current word: ", paste(correct_guesses, collapse = " "), "\n")
  guess <- tolower(readline(prompt = "Enter a letter: "))

# Using the previously set function to ensure that the guess/letter that the user inputs is valid.
# Using the "cat" function with it to alert the user that the guess/letter was not valid as decided by the negation of the function created.
  if (!is_valid_input(guess)) {
    cat("Invalid input. Please enter a single letter.\n")
    next
  }
 
# Setting the condition that if the guess/letter inputted by the user is already logged as a correct or incorrect guess previously attempted,
# the use of the "cat" function will alert the user that this guess/letter has already been attempted.
  if (guess %in% correct_guesses || guess %in% incorrect_guesses) {
    cat("You have already guessed that letter.\n")
    next
  }

# First, I am initializing the variable "found" to F, to keep track of whether the guess/letter is found in the secret word
# Using a "for" loop within to iterate through each position, i. 
# Using the "substr" function then in the "if" statement to check whether the character at position i matches with the guess/letter the user attempts.
  found <- FALSE
  for (i in 1:secret_word_length) {
    if (substr(secret_word, i, i) == guess) {
      correct_guesses[i] <- guess
      found <- TRUE
    }
  }

# Using an "if" statement to determine whether the previously-set variable "found" returns T, meaning that the letter/guess was indeed in the secret word.
# As usual, using the "cat" function to display the result (a correct guess) to the user.
# Using the "else" end of the statement in the case that the letter was not in the secret word, the letter is logged/recorded in the incorrect guesses, and the attempts are also logged.
# As usual again, using the "cat" function to display the result (an incorrect guess) to the user.
  if (found) {
    cat("Correct guess!\n")
  } else {
    cat("Wrong guess.\n")
    incorrect_guesses <- c(incorrect_guesses, guess)
    attempts <- attempts + 1
  }

# Using another "if" statement to specify victory in tandem with the "all" function, if all correct characters were guessed.
# Using the "cat" function again to display the victory message and reveal the secret word to the user.
  if (all(correct_guesses != "_")) {
    cat("Congratulations! You've guessed the word:", secret_word, "\n")
    break
  }

# Using "cat" functions to log and display the incorrect guesses and remaining attempts to the user.    
  cat("Incorrect guesses:", paste(incorrect_guesses, collapse = " "), "\n")
  cat("Remaining attempts:", max_attempts - attempts, "\n")
}

# Using an "if" statement in tandem with "cat" function to limit and display to the user when all the 6 allotted attempts have run out.
if (attempts == max_attempts) {
  cat("You've exhausted your attempts. The secret word was:", secret_word, "\n")
}
