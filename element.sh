#!/bin/bash

# read me
# This script take input related to elements and outputs details about those elements.
# If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, 
# it should output only "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.""

# echo "git branch -m main" (run this in terminal while on "master" branch to change its name)

# # connect to periodic_table database
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# arrays
declare -a user_input_elements
declare -a user_input_properties

# if the script is run without an argument
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
fi

# if the script is run with an argument
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
# else
#   echo "invalid argument :("
fi

element="$($PSQL "SELECT * FROM elements WHERE atomic_number = $1")"
properties="$($PSQL "SELECT * FROM properties WHERE atomic_number = $1")"

IFS='|'
read -ra user_input_elements <<< $element 
read -ra user_input_properties <<< $properties 
unset IFS

type="$($PSQL "SELECT type FROM types WHERE type_id = ${user_input_properties[4]};")"

echo ${user_input_elements[@]}
echo ${user_input_properties[@]}
echo $type




# how to get script to take user arguments (./element.sh H)
# element="$($PSQL "SELECT * FROM elements WHERE column = $user_input")"
# properties="$($PSQL "ELECT * FROM properties WHERE column = $user_input")"

# need if statements to check if user input is integer, 1 or 2 letters (symbol) or more than 2 letters (name)
# if [ $1 ]
# then use the appropriate sql queries (searching by user input, there will be 3 options)
# then return the appropriate response with requested details