#!/usr/bin/env python

# ABOUT ################
# This is an interactive script to learn Python. It follows the vide [Learn Python - Full Course for Beginners [Tutorial]](https://www.youtube.com/watch?v=rfscVS0vtbw)

# INTRODUCTION ################
# INSTALLING PYTHON & PYCHARM ################
# (skipped)
# SETUP & HELLO WORLD ################
# %%
print("Hello World")

# DRAWING A SHAPE ################
# %%
print("   /|")
print("  / |")
print(" /  |")
print("/___|")

# VARIABLES & DATA TYPES ################
# %%
character_name = "John"
character_age = "35"

print("There once was a man named " + character_name + ", ")
print("he was " + character_age + " years old. ")	
print("He really liked the name " + character_name + ", ")
print("but didn't like being " + character_age)

# %%
character_name = "John"
character_age = "35"

print("There once was a man named " + character_name + ", ")
print("he was " + character_age + " years old. ")	
character_name = "Mike" # change name
print("He really liked the name " + character_name + ", ")
print("but didn't like being " + character_age)

# %%
character_name = "John" # string
character_age = 35 # number - whole or decimal
is_male = True # boolean

print("There once was a man named " + character_name + ", ")
# print("he was " + character_age + " years old. ")	
character_name = "Mike" # change name
print("He really liked the name " + character_name + ", ")
# print("but didn't like being " + character_age)

# WORKING WITH STRINGS ################
# %%
print("Giraffe Academy")
# %% newline
print("Giraffe\nAcademy")

# %% escape characters
print("Giraffe\"Academy\\")

# %% string variable
phrase = "Giraffe Academy"
print(phrase)

# %% string concatenation
phrase = "Giraffe Academy"
print(phrase + " is cool")

# %% string functions (methods?)
phrase = "Giraffe Academy"
print(phrase.lower())
print(phrase.upper())
print(phrase.isupper()) # conditional variables
print(phrase.upper().isupper()) # combine methods

# %% length function
phrase = "Giraffe Academy"
print(len(phrase))

# %% string slicing
phrase = "Giraffe Academy"
print(phrase[0]) # python indices start at 0
print(phrase[3])

# %% index function
phrase = "Giraffe Academy"
print(phrase.index("G"))
print(phrase.index("f")) # only 1st instance
print(phrase.index("Academy"))

# %% replace function
phrase = "Giraffe Academy"
print(phrase.replace("Giraffe", "Elephant"))
# %%
# WORKING WITH NUMBERS ################
# %% print a number
print(2)
print(-2.0987)
print(3 + 4)
print(3 * 4.5)
print(3 * 4.5 + 5) # order of operations
print(3 * (4.5 + 5)) # order of operations

# %% modulus
print (10 % 3) # returns remainder from division

# %% number variables
my_num = 5
print(my_num)
# %% convert num into string
my_num = 5
print(str(my_num) + " is my favorite number")
# print(my_num + " is my favorite number") # fails
# %% number functions
my_num = -5
print(abs(my_num)) # absolute value
print(pow(my_num, 2)) # raise to power 2. same as '**' ?
print(max(my_num, 20)) # give max of numbers
print(min(my_num, 20)) # give min of numbers
print(round(3.7)) # give min of numbers
# %% importing external functions from a MODULE
from math import * # math = MODULE
print(floor(3.7))
print(ceil(3.7))
print(sqrt(36))
# %%
# GETTING INPUT FROM USERS ################
# %% get input and store as variable
name = input("Enter your name: ") # prompt goes inside ()
age = input("Enter your age: ") # prompt goes inside ()
print("Hello, " + name + "! You are " + age)
# %%

# BUILDING A BASIC CALCULATOR ################
# %% store 2 nums from user
num1 = input("Enter a number: ")
num2 = input("Enter another number: ")
result = num1 + num2
print(result) # prints as a concatenated string!

# result = int(num1) + int(num2) # correct for ints, but error on decimal numbers
# print(result)

result = float(num1) + float(num2) # works with floats
print(result)

# MAD LIBS GAME ################
# %% original poem
print("Roses are red")
print("Violets are blue")
print("I love you")
# %%
print("Roses are {color}")
print("{plural noun} are blue")
print("I love {celebrity}")

# %% user made variables
color = input("Enter a color: ")
plural_noun = input("Enter a plural noun: ")
celebrity = input("Enter a celebrity: ")

print("Roses are " + color)
print(plural_noun + " are blue")
print("I love " + celebrity)

# LISTS ################
# for large amounts of data
# %% make a list with []
friends = ['Kevin','Karen','Jim']
print(friends)
# %% print out item from list
# print 1st element
print(friends[0])
# print last element with negative index
print(friends[-1])
# access ranges in a list
friends = ['Kevin','Karen','Jim','Oscar','Toby']
print(friends[1:])
# modify elements
friends[1] = "Mike"
print(friends[1])

# LIST FUNCTIONS ################
# %%
lucky_numbers = [4, 8, 15, 16, 23, 42]
friends = ["Kevin", 'Karen','Jim','Oscar','Toby']
# print list
print(friends)
# %%
# extend function - append a list
friends.extend(lucky_numbers)
print(friends)
# %%
# add individual elements (works for strings too)
friends.append('Creed')
print(friends)
# %%
# add item to middle of list with insert()
friends.insert(1, 'Kelly')
print(friends)
# %%
# remove an element
friends.remove('Jim')
print(friends)
# %%
# delete all elements
friends.clear()
print(friends)
# %%
# remove last list element
friends = ["Kevin", 'Karen','Jim','Oscar','Toby']
friends.pop()
print(friends)
# %% test if value is in list
print(friends.index('Kevin'))
print(friends.index('Oscar'))
# friends.index('Mike') # error - not in list
# %% count similar elements in list
friends = ["Kevin",'Karen','Jim','Jim','Oscar','Toby']
print(friends.count('Jim'))
# %% sort a list
friends.sort()
print(friends)
# ^ some methods modify variables? what about strings:
my_string  = "HELLO"
my_string.lower() # does not modify a string...
print(my_string)
# %% sort numbers
lucky_numbers.sort()
print(lucky_numbers)

# %% reverse a list
lucky_numbers.reverse()
print(lucky_numbers)

# %% make a copy of a list
friends2 = friends.copy()
print(friends2)

# TUPLES ################
# data structure similar to lists but they are IMMUTABLE, whereas lists are MUTABLE - they get changed. You cant change tuples.
# %% tuples made with ()
coordinates = (4, 5)
print(coordinates[0:2])
# used for data that doesnt get changed

# %% try and change the tuple
# coordinates[0] = 1 # error

# %% make a list of tuples
coordinates = [
	(4, 5), # 0
	(6, 7), # 1
	(80, 34) # 2
]
print(coordinates[0])

# FUNCTIONS ################
# %% define a function
def sayHi():
	print("Hello user!")

sayHi() # prints the message
# %% scratch
def greetMe():
	name = input("Enter your name: ")
	print("Greetings, " + name + "!")

greetMe()

# %%
print("Top")
sayHi()
print("Bottom")
# %% pass parameters
def sayHi(name, age):
	print("Hello, " + name + "! You are " + str(age))

sayHi("Leo", 30)
sayHi("Amber", 29)
# %%

# RETURN STATEMENT ################
# for when you explicitly want a function to return some type of information back to you
# %% does not return a number
def cube(num):
	num**3 # doesnt return number

cube(3) # nothing returned
print(cube(3)) # 'none' returned
# %% return a value
def cube(num):
	return num**3
	# cant put any code after 'return' statement!

# call function
cube(3) # whats the difference between these two?
print(cube(3))

# %% store returned value in variable
result = cube(4)
print(result)

# IF STATEMENTS ################
# %%
is_male = True

if is_male:
	print("You are a male")
else:
	print("You are not a male")
# %% make more complex
# is_male = True
# is_tall = True
is_male = True
is_tall = False

if is_male or is_tall:
	print("You are male or tall or both")
else:
	print("You are neither male nor tall")

if is_male and is_tall:
	print("You are a tall male")
else:
	print("You are either not male or not tall or both")

# %% else if keyword
is_male = True
is_tall = True

if is_male or is_tall:
	print("You are male or tall or both")
elif is_male and not(is_tall):
	print("You are a short male")
elif not(is_male) and not(is_tall):
	print("You are not a male and not tall")
else:
	print("You are not male and not tall")

# IF STATEMENTS & COMPARISONS ################
# using if statements with comparisons
# %% 
# function for max number w 3 args
def max_num(num1, num2, num3):
	# return the largest of the 3 numbers
	if num1 >= num2 and num1 >= num3:
		return num1
	elif num2 >= num1 and num2 >= num3:
		return num2
	else:
		return num3

print(max_num(54,15,98))

# BUILDING A BETTER CALCULATOR ################
# to perform all basic arithmetic operations
# choose 2 numbers and an operator
# %%
num1 = float(input("Enter first number: "))
op = input("Enter operator: ")
num2 = float(input("Enter second number: "))

if op == "+":
	print(num1 + num2)
elif op == "-":
	print(num1 - num2)
elif op == "/":
	print(num1 / num2)
elif op == "*":
	print(num1 * num2)
else:
	print("Invalid operator")

# DICTIONARIES ################
# uses key:value pairs. 
# %% convert 3-digit month name into a full month name
month_conversions = {
	'Jan':'January',
	'Feb':'February',
	'Mar':'March',
	'Apr':'April',
	'May':'May',
	'Jun':'June',
	'Jul':'July',
	'Aug':'August',
	'Sep':'September',
	'Oct':'October',
	'Nov':'November',
	'Dec':'December',
}
# %% access dict
print(month_conversions['Nov']) # returns full name for November
print(month_conversions['Mar']) # returns full name for November

print(month_conversions.get("Apr", 'Not a valid key')) # use get method
print(month_conversions.get("MOOO", 'Not a valid key')) # revert to default string returned

# %% can also use numbers
dict2 = {
	1:"January",
	2:"February",
}

print(dict2[2]) # February

# WHILE LOOP ################
# %%
i = 1
while i <= 10: # keep looping while condition is true
	print(str(i) + ' is less than or equal to 10!')
	i += 1
print("Done with loop")

# BUILDING A GUESSING GAME ################
# using different data structures
# %%
# set secret word
secret_word = "giraffe"
# set users response
guess = ""
# need to get continual guesses until it's correct
while guess != secret_word:
	guess = input("Enter guess: ")

print("Correct guess!")
# %% set a limit on the number of guesses
# set secret word
secret_word = "giraffe"
# set users response
guess = ""
# keep track of number of guesses
guess_count = 0
# set limit for guesses
guess_limit = 3
# track if guesses remaining
out_of_guesses = False

# need to get continual guesses until it's correct
while guess != secret_word and not(out_of_guesses):
	if guess_count < guess_limit:
		guess = input("Enter guess: ")
		guess_count += 1
	else:
		out_of_guesses = True
	
if out_of_guesses:
	print("OUT OF GUESSES! YOU LOSE :( :( :(")
else:
	print("YOU WIN!!!")

# FOR LOOP ################
# loop over collections of items
# %% loop through letters in a string
for letter in 'Giraffe Academy':
	print(letter)
# %% loop through an array
friends = ['Jim','Karen','Kevin']
for friend in friends:
	print(friend)

# %% range of numbers
for i in range(10):
	print(i)
for i in range(3, 10):
	print(i)

# %% loop through length of array indices
for i in range(len(friends)):
	print(friends[i])

# %% use special logic
for i in range(5):
	if i == 0:
		print("First!")
	else:
		print('not first')
# EXPONENT FUNCTION ################
# make a function to mimic '**' exponential operator
# %%
def raiseToPower(base_num, pow_num):
	result = 1
	for i in range(pow_num):
		result *= base_num
	return result

print(raiseToPower(4, 160))

# 2D LISTS & NESTED LOOPS ################
