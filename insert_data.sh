#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != year ]]
then

echo $YEAR $ROUND $WINNER $OPPONENT $WINNER_GOALS $OPPONENT_GOALS

WINNER_ID=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")
if [[ -z $WINNER_ID ]]
then
INSERT_RESULT=$($PSQL "insert into teams(name) values ('$WINNER')")
fi

OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")
if [[ -z $OPPONENT_ID ]]
then
INSERT_RESULT=$($PSQL "insert into teams(name) values ('$OPPONENT')")
fi

WINNER_ID=$($PSQL "SELECT team_id FROM teams where name='$WINNER'")
OPPONENT_ID=$($PSQL "SELECT team_id FROM teams where name='$OPPONENT'")

LAST_INSERT=$($PSQL "insert into games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) values ($YEAR,'$ROUND',$WINNER_ID, $OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")

fi
done
   