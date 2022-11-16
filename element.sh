PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
else
  ELEMENTFOUND=$($PSQL "select E.atomic_number,E.symbol,E.name,T.type,P.atomic_mass,P.melting_point_celsius,boiling_point_celsius from properties P inner join elements E ON P.atomic_number=E.atomic_number inner join types T on P.type_id=T.type_id where E.atomic_number::text='$1' or E.symbol='$1' or E.name='$1';")

  echo "$ELEMENTFOUND" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR TYPE_ID BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE_ID, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
    done

  # if element not found
  if [[ -z $ELEMENTFOUND ]]
  then
    echo 'I could not find that element in the database.'

  fi

fi

