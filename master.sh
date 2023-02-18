#!/bin/bash

#Execute maintest.sh
./maintest.sh

# Check the exit status of maintest.sh
if [ $? -eq 0 ]; then
  echo "maintest.sh executed successfully. Running configtest.sh..."
  # Execute configtest.sh
  ./configtest.sh 
else
  echo "maintest.sh failed. configtest.sh will not be executed"
fi