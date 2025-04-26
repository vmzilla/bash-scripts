# Shell Scripting Quick Reference Guide

This repository contains useful shell scripts and this README serves as a quick reference guide to help you write shell scripts more efficiently.

## Table of Contents

- [Shell Scripting Quick Reference Guide](#shell-scripting-quick-reference-guide)
- [Basic Syntax](#basic-syntax)
- [Variables](#variables)
- [Control Flow](#control-flow)
- [Loops](#loops)
- [Functions](#functions)
- [Command Substitution](#command-substitution)
- [File Operations](#file-operations)
- [String Manipulation](#string-manipulation)
- [Date Formats](#date-formats)
- [Exit Codes](#exit-codes)
- [Input and Output](#input-and-output)

# Basic Syntax

```
#!/bin/bash             # Shebang - defines which interpreter to use
# This is a comment
echo "Hello World"      # Print to stdout
```

# Variables

## Variable assignment (no spaces around =)

```
NAME="John"
NUMBER=42
```
## Accessing variables

```
echo $NAME
echo "${NAME}"          # Recommended format for clarity
```

## Arrays

```
FRUITS=("Apple" "Banana" "Cherry")
echo ${FRUITS[0]}       # Access first element
echo ${FRUITS[@]}       # All elements
echo ${#FRUITS[@]}      # Array length
```

## Environment variables

`export MY_VAR="value"   # Make variable available to child processes`

# Control Flow

* Conditional Statements *

## If-else statement

```
if [[ $a -eq $b ]]; then
    echo "a equals b"
elif [[ $a -gt $b ]]; then
    echo "a is greater than b"
else
    echo "a is less than b"
fi
```

## Using && and || for short conditionals

`{ [ -f "file.txt" ] && echo "File exists"; } || echo "File does not exist"`

# Loops

## For loop (C-style)

```
for ((i=0; i<10; i++)); do
    echo $i
done
```

## For loop with list

```
for FRUIT in "${FRUITS[@]}"; do
    echo "Processing $FRUIT"
done
```

## While loop

```
COUNT=0
while [ $COUNT -lt 5 ]; do
    echo $COUNT
    ((COUNT++))
done
```

## Until loop

```
COUNT=5
until [ $COUNT -eq 0 ]; do
    echo $COUNT
    ((COUNT--))
done
```

## Break and continue

```
for i in {1..10}; do
    [ $i -eq 5 ] && continue  # Skip 5
    [ $i -eq 8 ] && break     # Stop at 8
    echo $i
done
```

# Functions

## Function declaration

```
function greet() {
    echo "Hello, $1!"
    return 0
}
```

## Alternative declaration

```
say_bye() {
    local name=$1    # Local variable
    echo "Goodbye, $name!"
}
```

## Function calls

```
greet "World"
say_bye "John"
```

# Command Substitution

## Store command output in a variable

`CURRENT_DIR=$(pwd)`

## Alternative syntax

`FILES=`ls -la``

## Use in string

`echo "Current directory is: $(pwd)"`

# File Operations

## Check if file exists

`[ -f "file.txt" ] && echo "File exists"`

## Check if directory exists

`[ -d "/tmp" ] && echo "Directory exists"`

* Common file test operators
* -e file exists
* -f regular file exists
* -d directory exists
* -s file is not zero size
* -r file is readable
* -w file is writable
* -x file is executable

# String Manipulation

## String length

```
STRING="Hello World"
echo ${#STRING}  # Outputs 11
```

## Substring

`echo ${STRING:0:5}  # Outputs "Hello"`

## Replace first occurrence

`echo ${STRING/World/Universe}  # Outputs "Hello Universe"`

## Replace all occurrences

`echo ${STRING//l/L}  # Outputs "HeLLo WorLd"`

## Check if string starts with substring

```
if [[ "$STRING" == "Hello"* ]]; then
    echo "String starts with Hello"
fi
```
## String comparison

```
if [[ "$STRING" == "Hello World" ]]; then
    echo "Strings are equal"
fi
```

# Date Formats

## Current date and time

`DATE=$(date)`

## Formatted date

```
TODAY=$(date +"%Y-%m-%d")  # 2025-04-24
TIME=$(date +"%H:%M:%S")    # 14:30:45
```

* Common date format strings
* %Y - four-digit year (e.g., 2025)
* %m - month (01-12)
* %d - day (01-31)
* %H - hour (00-23)
* %M - minute (00-59)
* %S - second (00-59)
* %s - seconds since 1970-01-01 00:00:00 UTC (Unix timestamp)
* %A - full weekday name (e.g., Sunday)
* %a - abbreviated weekday name (e.g., Sun)
* %B - full month name (e.g., January)
* %b - abbreviated month name (e.g., Jan)

# Exit Codes

```
# Success exit code
exit 0

# Error exit codes (1-255)
exit 1  # General errors
exit 2  # Misuse of shell builtins
exit 126  # Command invoked cannot execute
exit 127  # Command not found
exit 128  # Invalid argument to exit
exit 130  # Script terminated by Ctrl+C
exit 255  # Exit status out of range

# Get exit code of last command
echo $?
```

# Input and Output

## User input

```
read -p "Enter your name: " NAME
echo "Hello, $NAME!"
```

## Read with timeout (5 seconds)

`read -t 5 -p "Quick! Enter something: " INPUT`

## Read secret (no echo)

`read -s -p "Password: " PASSWORD`

## Redirect stdout to file

```
echo "Log entry" > logfile.txt    # Overwrite
echo "Another entry" >> logfile.txt  # Append
```

## Redirect stderr to stdout

`command 2>&1`

## Redirect both stdout and stderr to file

`command > file.txt 2>&1`

## Discard output

`command > /dev/null 2>&1`

