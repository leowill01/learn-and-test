# bash arrays
array=(one two three)
echo $array # prints 1st item
echo ${array[*]} # prints all
echo $array[*] # does not include '[*]' in the expression
echo ${array[2]} # prints 3rd element
unset array[1] ; echo ${array[*]} # removes 2nd item

# in zsh
