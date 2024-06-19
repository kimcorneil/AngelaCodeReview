#1. Prompt the user to enter a three digit positive number
#2. Check if the user input is numeric. If not, print an error message and quit.
#3. Check if the number is narcissistic. A narcissistic number, or an Armstrong number, is a number that is equal to the sum of the cubes of its own digits. 153, 370, 371, 407 are three digit Armstrong numbers.
#4. Display the result with an appropriate message, e.g. “127 is not an Armstrong number” or “370 is a narcissistic number” or any additional fun text you may want to add.


#1. Prompt the user to enter a three digit positive number
tdn <- readline(prompt = "Enter a three-digit positive number: ")


#2a. Check if the user input's three digit number (tdn) is numeric. 
# b. If the tdn is not numeric, print an error message and quit.
# NOTE: instead of "quitting", I opted for the "stop" option to prevent R-studio itself from quitting entirely.
if (is.na(as.numeric(enter_tdn))) { 
  print("Error: Input is not numeric") 
  stop(save = "no") 
  }

#3. Check if the tdn is narcissistic: The tdn must be first split into digits to check if the sum of the cubes of these digits equates to the number itself.
# To extract the digits on their own, we need to first convert them the tdn into a character string.
tdn_string <- as.character(tdn)
# After conversion, we can now extract the digits individually using the "strpsplit" function.
tdn_split <- strsplit(tdn_string, split = "")
# In order to then work with these digits, we must then convert these individual digits into a vector using the "unlist" function.
# NOTE: This process is called "flattening".
tdn_flat <- unlist(tdn_split)
# This "flattened" vector is of characters; in order to perform math on it (like taking cubes and sums) we need integers; use the "as.integer" function to convert the character vector into an integer vector.
tdn_digits <- as.integer(tdn_flat)
# Now, we have extracted, integer digits that we may perform math on. Use the "sum" function and "^3" operation to take the sum of the cubed three digits.
tdn_sum_of_cubes <- sum(tdn_digits^3)


