#!/usr/bin/env bash

# Check if alias already exists in the .bash_profile
grep -q 'alias tf="terraform"' ~/.bash_profile

if [ $? -ne 0 ]; then
  # If the alias does not exists, appent it
  echo 'alias tf="terraform"' >> ~/.bash_profile
  echo "Alias added succesfully"
else
  # Inform the user that alias already exists
  echo "Alias already exists in .bash_profile"
fi

# Check is terraform autocompletion enable in the .bash_profile
grep -q 'complete -C /usr/bin/terraform terraform' ~/.bash_profile

if [ $? -ne 0 ]; then
  # If the alias does not exists, appent it
  echo 'complete -C /usr/bin/terraform terraform' >> ~/.bash_profile
  echo "Terraform autocompletion enabled"
else
  # Inform the user that alias already exists
  echo "Terraform autocompletion was already enabled in .bash_profile"
fi

# Check is terraform autocompletion for alias tf enable in the .bash_profile
grep -q 'complete -C /usr/bin/terraform tf' ~/.bash_profile

if [ $? -ne 0 ]; then
  # If the alias does not exists, appent it
  echo 'complete -C /usr/bin/terraform tf' >> ~/.bash_profile
  echo "Terraform autocompletion for alias tf enabled"
else
  # Inform the user that alias already exists
  echo "Terraform autocompletion for alias tf was already enabled in .bash_profile"
fi

# Source the .bash_profile to make the alias and autocompletion available immediatly
source ~/.bash_profile