#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

NUMBER_OR_WORD(){
if [[ $1 =~ ^[0-9]+$ ]]
then
  NUMBER "$1"
fi

if [[ $1 =~ ^[a-zA-Z]+$ ]] 
then
  WORD "$1"
fi

}

NUMBER(){
  NUMBER=$1
  NUMBER_INFO=$($PSQL "SELECT * FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")
  if [[ -z $NUMBER_INFO ]]
  then
    echo -e "I could not find that element in the database."
  else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")

    SYMBOL=$($PSQL "SELECT symbol FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")

    NAME=$($PSQL "SELECT name FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")

    TYPE=$($PSQL "SELECT type FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")

    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")

    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")

    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements join properties using(atomic_number) join types using(type_id) WHERE atomic_number = $NUMBER")

    # # type_id | atomic_number | symbol | name | atomic_mass | melting_point_celsius | boiling_point_celsius | type

      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

  fi
}

WORD(){
  WORD=$1
  WORD_INFO=$($PSQL "SELECT * FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")
  if [[ -z $WORD_INFO ]]
  then
    echo -e "I could not find that element in the database."    
  else
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")

    SYMBOL=$($PSQL "SELECT symbol FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")

    NAME=$($PSQL "SELECT name FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")

    TYPE=$($PSQL "SELECT type FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")

    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")

    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")

    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM elements join properties using(atomic_number) join types using(type_id) WHERE symbol = '$WORD' OR name = '$WORD'")

      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

  fi
}

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else 
  NUMBER_OR_WORD "$1"
fi

# if argument is 1/H/Hydrogen, output should say
# "The element with atomic 1 is Hydrogen (H). It's a nonmental, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."

