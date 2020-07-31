#! /usr/bin/bash

# Welcome and taking the request
echo "		Welcome to the Shell Library."
echo "======================================================"
echo "We have a wide range of Book available"
echo "Please enter your name:"
declare -x student_name
read student_name
echo "please enter your student-id:"
declare -x student_id
read student_id
echo "Hello $student_name hope you are having great day."
echo "======================================================="
echo "what would you like to do today? (please enter the number of your request)"
echo "1.Check-out a book"
echo "2.Check-in a book"
echo "3.Check your favourite book availabilty"
echo "======================================================="
read request
