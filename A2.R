#1. Prompt the user to enter a three digit positive number
#2. Check if the user input is numeric. If not, print an error message and quit.
#3. Check if the number is narcissistic. A narcissistic number, or an Armstrong number, is a number that is equal to the sum of the cubes of its own digits. 153, 370, 371, 407 are three digit Armstrong numbers.
#4. Display the result with an appropriate message, e.g. “127 is not an Armstrong number” or “370 is a narcissistic number” or any additional fun text you may want to add.


#1. Prompt the user to enter a three digit positive number
enter_tdn <- readline(prompt = "Enter a three-digit positive number: ")

#2. Check if the user input is numeric. If not, print an error message and quit.
if (is.na(as.numeric(enter_tdn))) { 
  print("Error: Input is not numeric") 
  stop(save = "no") 
  }

#3. Check if the number is narcissistic. A narcissistic number, or an Armstrong number, is a number that is equal to the sum of the cubes of its own digits. 153, 370, 371, 407 are three digit Armstrong numbers.
