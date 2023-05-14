#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z "$1" ]]; then
  echo Please provide an element as an argument.
else
  if  [[ $1 =~ ^[0-9]+$ ]]; then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    if [[ -z $ATOMIC_NUMBER ]]; then
      echo I could not find that element in the database.
    else
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      MPC=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      BPC=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
    fi
  else
    if [[ $1 =~ ^[A-Z][a-z]?$ ]]; then
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
      if [[ -z $SYMBOL ]]; then
      echo I could not find that element in the database.
      else
        NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$SYMBOL'")
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
        MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        MPC=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        BPC=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
    fi
    else
      NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
      if [[ -z $NAME ]]; then
        echo I could not find that element in the database.
      else
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$NAME'")
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$NAME'")
        MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        MPC=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        BPC=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
        TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
      fi
    fi
  fi
fi