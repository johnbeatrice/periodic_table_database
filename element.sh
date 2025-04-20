#!/bin/bash

# read me
# This script take input related to elements and outputs details about those elements.
# If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, 
# it should output only "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.""

# echo "git branch -m main" (run this in terminal while on "master" branch to change its name)

echo "Please provide an element as an argument."

if [[ $1 =~ ^-?[0-9]+$ ]]
then
  echo "$1 is an integer!"
elif [[ ${#1} > 0 && ${#1} < 3 ]]
then
  echo "$1 is a symbol!"
  echo ${#1}
elif [[ ${#1} > 2 ]]
then
  echo "$1 is a name!"
  echo ${#1}
else
  echo "invalid argument :("
fi


# how to get script to take user arguments (./element.sh H)
# element="$($PSQL "SELECT * FROM elements WHERE column = $user_input")"
# properties="$($PSQL "ELECT * FROM properties WHERE column = $user_input")"

# need if statements to check if user input is integer, 1 or 2 letters (symbol) or more than 2 letters (name)
# if [ $1 ]
# then use the appropriate sql queries (searching by user input, there will be 3 options)
# then return the appropriate response with requested details