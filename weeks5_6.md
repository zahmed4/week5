# Weeks 5 and 6 Outline (Bash scripting)

## Questions and Troubleshooting

- Sublime and Visual Studio Code
- Nuances of regex with grep and sed
- Regex assignment now due Tuesday (Sept. 25th)
- If your VM has trouble with its internet connection, try removing and re-adding your network adapter

- To pull latest changes from class repo:
  - `git remote add class <HTTPS_URL_TO_CLASS_REPO>`
  - `git pull class master`

## Introduction to scripts

- [ ] Adjusting $PATH
  - As we've discussed in previous classes, PATH is a built-in environmental variable in bash.
  - It tells the bash shell where to look for commands that you type in Terminal.
  - However, you can adjust PATH manually as you see fit.
  - Remember that to look at (or more generally access) the value of a variable, you need to precede it with $ - e.g., $PATH.
  - Start by looking at the current value of PATH - echo $PATH
    - Notice that this gives you a list of absolute paths to directories separated by :. The best way to make your custom scripts accessible from the command line is to create a folder (~/scripts is a good option) and add it to your PATH.
  - First, you need to create your scripts folder.
  - Next, you need to add it to your PATH variable.
      - PATH=$PATH":/home/compbio/scripts"
      - Note how you can just glue two strings together in bash, even if one is a variable.
  - Re-examine the value of PATH to make sure your new absolute path has been added
  - In a bit, we'll add a new script to this folder. If PATH has been set properly, it should automatically show up on the command line.
  - Close your Terminal. Now re-open it and look at PATH again. What happened?
  - Persistent changes to environmental variables can be made


- [ ] What is a script?
  - Fundamentally, a bash script is just a file containing a series of bash commands.
  - Scripts are formatted as text files. But the things in this file are special.
  - The first line of a script file tells the computer in which language (i.e., shell) we're writing our script. This line starts with "#!" - also known as a shebang. The shebang tells Terminal that we're about to indicate which language we're going to use.
  - Follow the shebang with the path to the shell that you'd like to use. Yes, the shell itself is a program!
    - #! /bin/bash
  - Let's start by creating your first script - myScript.sh
    - nano myScript.sh
    - Add the shebang line
    - Add two commands in the body of the file
      - echo "Hello, "$USER"!"
      - echo "I'M A SCRIPT AND I WORK!"


- [ ] Scripts contain series of commands
  - This is essentially your first foray into programming.
  - You'll need to think through the steps involved in whatever task you need to complete and then write a command for each step.
  - This ability to break a big problem into individual steps is the most important skill in programming.
  - As an example, let's write a program together to do a basic analysis of a dna sequence. This sequence is already available in the week 5 repository in `dnaSequence.txt`. This is a real sequence from the human genome (at least, some human genomes) and we'd like to count the number of As, Cs, Gs, and Ts that it contains.

```
    Counting Nucleotides Script

    1. Create a new script file
    2. Add the shebang line at the top
    3. For now, include the sequence directly in the script in a variable called `dnaSeq`.
    4. What's one way to count characters? How do we extract just one kind of character?

    Go search through [Genbank](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch) for this sequence.
    What is it? Any idea why it's interesting?
```

```
    Translating DNA to RNA Script

    Ok, now on your own make a copy of the script we just created and modify it to
    instead translate our dna sequence into an rna sequence. Remember, the only
    difference is that RNA sequences have a u where a dna sequence has a t.
```


- [ ] Command-line Arguments
  - For the scripts we just created, we manually included the value for the string representing our sequence inside the file. However, for scripts like these, it will usually be more convenient to be able to pass the same script different values, without changing the script itself.
  - One way to accomplish this is to pass the sequence as a command-line argument to the script
    - `countNucleotides.sh <SEQUENCE>`
    - To access the argument from inside the script, bash reserves the special variables $1, $2, $3, ...
    - For practice, go back to `myScript.sh` that we created earlier and change `$USER` to `$1`. Now, run it by typing `myScript.sh <YOUR_NAME>`
    - Now update your DNA counting and translation scripts to take a sequence on the command line, rather than defining them in the script. Check to make sure they work!


- [ ] For loops
  - One of the most common things you'll need to do in any program you write, whether it's a bash shell script, Python, or another language, is repeat something many times.
  - One versatile way to accomplish repitition is to use a `for` loop. Bash `for` loops have the following structure:
        for num in 1 two 3 FOUR
        do
            echo $num
        done

  - Let's break this down. First, we've defined a new variabled named `num`. This variable can be named anything you want.
  - `num` will iteratively take the value of anything included in the list that follows `in`.
  - During each iteration, the code in between `do` and `done` will be executed. In this case, we will simply print out each of the values our variable takes, one after the other.
  - To make sure you can get a for loop to work, go ahead and make a new script called `loopTest.sh` and include this for loop. Run the script and make sure it prints out each of the values you provided.
  - Sometimes you'll want to loop through a whole series of command line arguments. To loop through these arguments, you can write `$@` in place of the list in your `for` statement.
        for num in $@
        do
          echo $num
        done
  - Now, pass a series of command-line arguments and see if your script will print them out.

```
  Changing file extensions

  Let's say you have a whole series of files that end with the extension .txt
  and you'd like to rename them to have .text extensions. But, you don't know
  how many .txt files you might have or what their names will be. Thankfully,
  this is where wildcards become incredibly helpful. Remember that (unlike regex)
  the bash shell uses a single * as its most general wildcard. So, typing *.txt
  will automatically give you all the filenames that end with .text.

  Next, you'll need two more bash tricks. First, there's a special command called
  basename that strips off whatever text you want from the end of a string. So, typing

  basename test.txt .txt

  will give you just "test" in return.

  Lastly, you'll need to know how to capture the output of running basename and
  save it in a variable. To do this, surround the code you want to execute in backticks
  - `<CODE_HERE>`. To try it out, type these directly on the command line:

  fileName=`basename test.txt .txt`
  echo $fileName

  Ok, now see if you can create a script that uses a for loop to go through all
  of the .txt files in a folder and give them the extension of .text.

  NOTE - This is not the only way to accomplish this. Can you think of others?
```

- [ ] Flow control with if...else
  - One of the other very important programming concepts is known as "flow control". Basically, this just means doing different things depending on current conditions.
  - There are several types of flow control structures, but probably the most common is the if...else statement, which looks like this:
        if <TEST_SOMETHING>
        then
          <DO_THING_1>
        else
          <DO_THING_2>
        fi

 - There are lots of different ways to compare values, depending on what type of values you're working with. Here is a page that lists several options: [Bash comparison operators](http://tldp.org/LDP/abs/html/comparison-ops.html)
 - Here's one example:
        # Defining value of numeric variable
        a=2

        # if...else to see if value of number is at least 3
        if [ $a -lt 3 ]  # Note: this could also be ((a < 3))
        then
          echo "$a is less than 3."
        else
          echo "$a is NOT less than 3."
        fi
 - Here's another example where we compare word lengths and pass the first word on the command line:
        # Recording length of word provided on command line
        # What's going on with the backticks (``) here?
        myWordLength=`echo -n $1 | wc -m`

        # if...else to see if word is at least 5 characters
        if [ $myWordLength -lt 5 ]
        then
          echo "$1 is shorter than 5 characters."
        else
          echo "$1 is at least 5 characters in length."
        fi


- [ ] Math in bash (one way)
  - In general, bash isn't very good for mathematical operations, but it can be done in several ways
  - Probably the easiest is to wrap a mathematical expression in _double_ parentheses and precede it with a `$`, since you pretty much always want the _value_ of the mathematical result
    - `echo $(( 2 + 2 ))`
      - `myNum = $(( 2 + 2 ))`
    - `echo $(( 3 * 6 ))`
    - `echo $(( 20 / 3 ))`
    - `echo $(( 20 % 3 ))`
    - Compare the output of these last two lines? What's going on?
  - NOTE: bash can only handle _integers_ and not floating-point numbers (i.e., decimals)
  - Try this. What happens?
    - `myVar=3`
    - `echo $myVar`
    - `((myVar++))`
    - `echo $myVar`
    - `((myVar++))`
    - `echo $myVar`
  - What does the `++` operator do?
  - The double parentheses notation can also be used to write a `for` loop in a different way:
        for ((i=1;i<=10;i++))
        do
            echo $i
        done
    - When written this way the `for` loop statement has a structure like this:
        - `for (( <START_VALUE> ; <STOP_CONDITION> ; <LOOP_UPDATE>))`
  - NOTE: You _don't_ precede variables with `$` inside double parentheses


- [ ] Flow control with while
  - Another flow control structure is a `while` loop
  - A `while` loop just has a single condition that it waits to be satisfied before exiting
  - `while` loops are somewhat more flexible than `for` loops, because they can run for a variable number of iterations, depending on the conditions.
  - WARNING: Because `while` loops don't automatically
        i=1
        while [ $i -lt 11 ]
        do
            echo $i
            (( i++ ))
        done
  - OR
        i=1
        while (( i<11 ))
        do
            echo $i
            (( i++ ))
        done


- [ ] Reading in values interactively
  - You can accept values directly from users by using `read`. In general, you'll want to prompt the user, then follow the prompt with `read <VARIABLE>`. Whatever the user types in will be stored in that variable.
  - Here's basic usage:
        echo -n "Please type your name: "
        read name
        echo "Hello, "$name
  - Here's an application that uses a while loop:
        echo "Try to guess the word I'm thinking of: "
        read word
        while [ $word != "tigers" ]
        do
            echo "Try again to guess the word: "
            read word
        done
        echo "You finally got it!"


- [ ] Using a while loop to read values from a file
  - You can send the contents of a file into a `while` loop that uses `read` to go through lines in a file one-by-one.
        while read line
        do
            echo $line
        done < "$1"

- [ ] Additional command-line utilities
  - There are more command line utilities to help process files that could prove useful, especially as you begin to create workflows in scripts.
  - `cut` can be used to extract columns from files. For instance, if we go back to one of the files we used last week to look at lake temperatures (`FILE="Strdln_Twater_090611-090828_corrd_sm.csv"`)
    - `tail -n +2 $FILE | head -n 10 | cut -f 3 -d ";"` - This uses tail to extract all lines starting at line 2, then uses head to keep only the first 10 of those lines, then uses cut to extract the 3rd column delimited by a semicolon (;).
  - `sort` can be used to sort values in a column. The `-n` flag sorts based on numeric value (rather than alphabetically).
    - `tail -n +2 $FILE | cut -f 3 -d ";" | sort -n | head -n 20` - What would this do?
    - The `-r` flag to sort will reverse the order of sorting. So, what would this do?
      - `tail -n +2 $FILE | cut -f 3 -d ";" | sort -nr | head -n 20`
      - What could we learn by comparing the output of these two commands?
  - `uniq` is also a useful utility. It will remove _consecutive, duplicate_ lines. This can be very powerful when combined with sort. For instance, compare the output from these lines:
    - `tail -n +2 $FILE | cut -f 3 -d ";" | sort -n | head -n 20`
    - `tail -n +2 $FILE | cut -f 3 -d ";" | sort -n | head -n 20 | uniq`
    - `tail -n +2 $FILE | cut -f 3 -d ";" | sort -n | head -n 20 | uniq | wc -l`
    - `tail -n +2 $FILE | cut -f 3 -d ";" | sort -n | head -n 20 | uniq -c`
    - Use `uniq`'s man page to figure out what the `-c` flag does.

## Week 6 Assignment (due Tuesday, Oct. 2nd)

Be sure to include comments with the code you write for each of these!

(1) Write a script that uses a `for` loop to read a series of integers from the command line. The script should both (a) count the number of values less than 10 and (b) add all the numbers together. Both values should be printed to the screen.

(2) Write a script that does the same thing as (1), but reads the values from a file.

(3) Write a script that reads in two columns of numbers from a file. The columns are separated by a tab. Have it output any lines where the first column contains a number greater than 10 and the second column contains a number less than 10. HINT: there are multiple ways to do this.


## Week 5 Assignment (due Thursday, Sept. 27th)

Your assignment for this week is to create a script that does something useful. You get to pick what the goal of your program is, but it must satisfy these requirements:

- Must be a bash script
- Must accept an arbitrary number of command-line arguments
- Must include at least one for loop
- Must include at least one if...else statement

The assignment steps are:

- Start by forking the week 5 repository
- Clone it to your computer and create a branch with your name
- Create a file to hold your bash script (ending with `.sh`). Save it with a name that has something to do with its purpose.
- Write your code in your script file.
- Commit your file to your branch
- Push your new branch to your fork
- Submit a pull request for your new branch from your fork to the class repository
