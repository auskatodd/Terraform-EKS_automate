#!/bin/bash

# Run maintest.sh
echo "Running maintest.sh..."
./maintest.sh

# Check the exit status of maintest.sh
maintest_status=$?
if [ $maintest_status -eq 0 ]; then
  echo "maintest.sh executed successfully. Running configtest.sh..."
  # Execute configtest.sh
  ./configtest.sh 
else
  echo "maintest.sh failed with exit code $maintest_status. configtest.sh will not be executed."
fi

# Check the exit status of configtest.sh
configtest_status=$?
if [ $configtest_status -eq 0 ]; then
  echo "configtest.sh executed successfully."
else
  echo "configtest.sh failed with exit code $configtest_status."
fi
