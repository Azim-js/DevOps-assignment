#!/bin/bash

# sort and count the status codes occuring in access_log.txt  - using awk command

echo "========================="

echo -e "\n Question 1 :"

echo -e "HTTP_STATUS \n"

awk 'NF > 0 {print $9}' access_log.txt | sort | uniq -c | sort -n | awk '{print $2 "-" $1}'


# count the unique IP address in the access_log.txt
echo "======================="
echo -e "\nQuestion 2 :"

echo -n "UNIQUE_CLIENT_ADDRESS - " 

awk 'NF > 0 {print $1}' access_log.txt | sort | uniq -c | wc -l

# for every line in the file count the words , which are sperated by space 

echo "=========================="

echo -e "Line count_of_words \nLine_Number | Count \n"

awk '{print NR "|" NF}' access_log.txt