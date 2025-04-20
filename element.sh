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

# *** if the script is run with an argument ***
# if the argument is an integer
if [[ $1 =~ ^-?[0-9]+$ ]]
then
  echo "$1 is an integer!"
  #  get element info from elements and properties info
  element="$($PSQL "SELECT * FROM elements WHERE atomic_number = $1;")"
  properties="$($PSQL "SELECT * FROM properties WHERE atomic_number = $1;")"

  # if element does not exist in db, exit script
  if [[ -z $element ]]
  then
  echo "I could not find that element in the database."
  exit
  fi

  # input element and properties values into arrays
  IFS='|'
  read -ra user_input_elements <<< $element 
  read -ra user_input_properties <<< $properties 
  unset IFS

  # get element type
  type="$($PSQL "SELECT type FROM types WHERE type_id = ${user_input_properties[4]};")"

  # response to user
  echo "The element with atomic number ${user_input_elements[0]} is ${user_input_elements[2]} ${user_input_elements[1]}. It's a $type, with a mass of ${user_input_properties[1]} amu. ${user_input_elements[2]} has a melting point of ${user_input_properties[2]} celsius and a boiling point of ${user_input_properties[3]} celsius."

# if the argument is a 1 or 2 character string
elif [[ ${#1} > 0 && ${#1} < 3 ]]
then
  echo "$1 is a symbol!"

  #  get element info from elements table
  element="$($PSQL "SELECT * FROM elements WHERE symbol = '$1';")"

  echo $element

  # if element does not exist in db, exit script
  if [[ -z $element ]]
  then
  echo "I could not find that element in the database."
  exit
  fi

  # input element values into array
  IFS='|'
  read -ra user_input_elements <<< $element 
  unset IFS

  # get info from properties table
  properties="$($PSQL "SELECT * FROM properties WHERE atomic_number = ${user_input_elements[0]};")"
  # input properties values into array
  IFS='|'
  read -ra user_input_properties <<< $properties 
  unset IFS

  # get element type
  type="$($PSQL "SELECT type FROM types WHERE type_id = ${user_input_properties[4]};")"

  # response to user
  echo "The element with atomic number ${user_input_elements[0]} is ${user_input_elements[2]} ${user_input_elements[1]}. It's a $type, with a mass of ${user_input_properties[1]} amu. ${user_input_elements[2]} has a melting point of ${user_input_properties[2]} celsius and a boiling point of ${user_input_properties[3]} celsius."

# if the argument is a string longer than 2 characters
elif [[ ${#1} > 2 ]]
then
  echo "$1 is a name!"

  #  get element info from elements table
  element="$($PSQL "SELECT * FROM elements WHERE name = '$1';")"

  # if element does not exist in db, exit script
  if [[ -z $element ]]
  then
  echo "I could not find that element in the database."
  exit
  fi

  # input element and properties values into arrays
  IFS='|'
  read -ra user_input_elements <<< $element 
  unset IFS
  
  # get info from properties table
  properties="$($PSQL "SELECT * FROM properties WHERE atomic_number = ${user_input_elements[0]};")"
  # input properties values into array
  IFS='|'
  read -ra user_input_properties <<< $properties 
  unset IFS
  # get element type
  type="$($PSQL "SELECT type FROM types WHERE type_id = ${user_input_properties[4]};")"

  # response to user
  echo "The element with atomic number ${user_input_elements[0]} is ${user_input_elements[2]} ${user_input_elements[1]}. It's a $type, with a mass of ${user_input_properties[1]} amu. ${user_input_elements[2]} has a melting point of ${user_input_properties[2]} celsius and a boiling point of ${user_input_properties[3]} celsius."
  
fi