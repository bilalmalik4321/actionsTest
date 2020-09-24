# Creates a file to capture standard out
rm -rf yarn_install_output.txt
touch yarn_install_output.txt

# Run NPM install (Mentions vulnerabilities at the end). Output goes into file.
yarn install >> yarn_install_output.txt

yarn audit >> yarn_install_output.txt

search_term=", [0-9]{1,6} high)"

if grep -REo "$only_high_vulnerabilities" yarn_install_output.txt
then
  if ! grep -o "found 0 vulnerabilities" yarn_install_output.txt
  then
    echo "Yes, security vulnerabilities found."
    exit 1
  fi
fi

echo "No, security vulnerabilities found."
