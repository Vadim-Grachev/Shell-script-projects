#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]*+$ ]]
  then
  ELEMENT_ID=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number LEFT JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number = $1")
  else
  ELEMENT_ID=$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number LEFT JOIN types ON properties.type_id = types.type_id WHERE symbol = '$1' OR name = '$1'")
  fi
  if [[ -z $ELEMENT_ID ]]
  then
  echo 'I could not find that element in the database.'
  else 
  ELEMENT_ID_FORMATTED=$(echo $ELEMENT_ID | sed 's/|/ /g')
  echo $ELEMENT_ID_FORMATTED | while read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MPC BPC TYPE
  do
  echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
  done
  fi
fi