#echo -e 'Please provide an element as an argument.'
#echo $1
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo 'Please provide an element as an argument.'
else
  ELEMENTFOUND=$($PSQL "select * from properties P inner join elements E ON P.atomic_number=E.atomic_number where E.atomic_number::text='$1' or E.symbol='$1' or E.name='$1';")

  echo $ELEMENTFOUND

  # if element not found
  if [[ -z $ELEMENTFOUND ]]
  then
    echo 'I could not find that element in the database.'

  fi

fi

