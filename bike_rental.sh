{\rtf1\ansi\ansicpg1252\deff0\nouicompat\deflang1033{\fonttbl{\f0\fnil\fcharset0 Calibri;}}
{\*\generator Riched20 10.0.18362}\viewkind4\uc1 
\pard\sa200\sl276\slmult1\f0\fs22\lang9 #!/bin/bash\par
\par
PSQL="psql -X --username=freecodecamp --dbname=bikes --tuples-only -c"\par
\par
echo -e "\\n~~~~~ Bike Rental Shop ~~~~~\\n"\par
\par
MAIN_MENU() \{\par
  if [[ $1 ]]\par
  then\par
    echo -e "\\n$1"\par
  fi\par
\par
  echo "How may I help you?" \par
  echo -e "\\n1. Rent a bike\\n2. Return a bike\\n3. Exit"\par
  read MAIN_MENU_SELECTION\par
\par
  case $MAIN_MENU_SELECTION in\par
    1) RENT_MENU ;;\par
    2) RETURN_MENU ;;\par
    3) EXIT ;;\par
    *) MAIN_MENU "Please enter a valid option." ;;\par
  esac\par
\}\par
\par
RENT_MENU() \{\par
  # get available bikes\par
  AVAILABLE_BIKES=$($PSQL "SELECT bike_id, type, size FROM bikes WHERE available = true ORDER BY bike_id")\par
\par
  # if no bikes available\par
  if [[ -z $AVAILABLE_BIKES ]]\par
  then\par
    # send to main menu\par
    MAIN_MENU "Sorry, we don't have any bikes available right now."\par
  else\par
    # display available bikes\par
    echo -e "\\nHere are the bikes we have available:"\par
    echo "$AVAILABLE_BIKES" | while read BIKE_ID BAR TYPE BAR SIZE\par
    do\par
      echo "$BIKE_ID) $SIZE\\" $TYPE Bike"\par
    done\par
\par
    # ask for bike to rent\par
    echo -e "\\nWhich one would you like to rent?"\par
    read BIKE_ID_TO_RENT\par
\par
    # if input is not a number\par
    if [[ ! $BIKE_ID_TO_RENT =~ ^[0-9]+$ ]]\par
    then\par
      # send to main menu\par
      MAIN_MENU "That is not a valid bike number."\par
    else\par
      # get bike availability\par
      BIKE_AVAILABILITY=$($PSQL "SELECT available FROM bikes WHERE bike_id = $BIKE_ID_TO_RENT AND available = true")\par
\par
      # if not available\par
      if [[ -z $BIKE_AVAILABILITY ]]\par
      then\par
        # send to main menu\par
        MAIN_MENU "That bike is not available."\par
      else\par
        # get customer info\par
        echo -e "\\nWhat's your phone number?"\par
        read PHONE_NUMBER\par
\par
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$PHONE_NUMBER'")\par
\par
        # if customer doesn't exist\par
        if [[ -z $CUSTOMER_NAME ]]\par
        then\par
          # get new customer name\par
          echo -e "\\nWhat's your name?"\par
          read CUSTOMER_NAME\par
\par
          # insert new customer\par
          INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$PHONE_NUMBER')") \par
        fi\par
\par
        # get customer_id\par
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$PHONE_NUMBER'")\par
\par
        # insert bike rental\par
        INSERT_RENTAL_RESULT=$($PSQL "INSERT INTO rentals(customer_id, bike_id) VALUES($CUSTOMER_ID, $BIKE_ID_TO_RENT)")\par
\par
        # set bike availability to false\par
        SET_TO_FALSE_RESULT=$($PSQL "UPDATE bikes SET available = false WHERE bike_id = $BIKE_ID_TO_RENT")\par
\par
        # get bike info\par
        BIKE_INFO=$($PSQL "SELECT size, type FROM bikes WHERE bike_id = $BIKE_ID_TO_RENT")\par
        BIKE_INFO_FORMATTED=$(echo $BIKE_INFO | sed 's/ |/"/')\par
        \par
        # send to main menu\par
        MAIN_MENU "I have put you down for the $BIKE_INFO_FORMATTED Bike, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."\par
      fi\par
    fi\par
  fi\par
\}\par
\par
RETURN_MENU() \{\par
  # get customer info\par
  echo -e "\\nWhat's your phone number?"\par
  read PHONE_NUMBER\par
\par
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$PHONE_NUMBER'")\par
\par
  # if not found\par
  if [[ -z $CUSTOMER_ID  ]]\par
  then\par
    # send to main menu\par
    MAIN_MENU "I could not find a record for that phone number."\par
  else\par
    # get customer's rentals\par
    CUSTOMER_RENTALS=$($PSQL "SELECT bike_id, type, size FROM bikes INNER JOIN rentals USING(bike_id) INNER JOIN customers USING(customer_id) WHERE phone = '$PHONE_NUMBER' AND date_returned IS NULL ORDER BY bike_id")\par
\par
    # if no rentals\par
    if [[ -z $CUSTOMER_RENTALS  ]]\par
    then\par
      # send to main menu\par
      MAIN_MENU "You do not have any bikes rented."\par
    else\par
      # display rented bikes\par
      echo -e "\\nHere are your rentals:"\par
      echo "$CUSTOMER_RENTALS" | while read BIKE_ID BAR TYPE BAR SIZE\par
      do\par
        echo "$BIKE_ID) $SIZE\\" $TYPE Bike"\par
      done\par
\par
      # ask for bike to return\par
      echo -e "\\nWhich one would you like to return?"\par
      read BIKE_ID_TO_RETURN\par
\par
      # if not a number\par
      if [[ ! $BIKE_ID_TO_RETURN =~ ^[0-9]+$ ]]\par
      then\par
        # send to main menu\par
        MAIN_MENU "That is not a valid bike number."\par
      else\par
        # check if input is rented\par
        RENTAL_ID=$($PSQL "SELECT rental_id FROM rentals INNER JOIN customers USING(customer_id) WHERE phone = '$PHONE_NUMBER' AND bike_id = $BIKE_ID_TO_RETURN AND date_returned IS NULL")\par
        # if input not rented\par
        if [[ -z $RENTAL_ID ]]\par
        then\par
        # send to main menu\par
        MAIN_MENU "You do not have that bike rented."\par
        else\par
          # update date_returned\par
          RETURN_BIKE_RESULT=$($PSQL "UPDATE rentals SET date_returned = NOW() WHERE rental_id = $RENTAL_ID")\par
          # set bike availability to true\par
          SET_TO_TRUE_RESULT=$($PSQL "UPDATE bikes SET available = true WHERE bike_id = '$BIKE_ID_TO_RETURN'")\par
          # send to main menu\par
          MAIN_MENU "Thank you for returning your bike."\par
        fi\par
      fi\par
    fi\par
  fi\par
\}\par
\par
EXIT() \{\par
  echo -e "\\nThank you for stopping in.\\n"\par
\}\par
\par
MAIN_MENU\par
}
 