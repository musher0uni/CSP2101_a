#!/bin/bash
# Megan Usher
# 10496521
# Portfolio 1 



(( count=0 ))

# Compare the user's guess to the random number generated. Then produce appropriate output.
while true
do

    read -p $'\n'"Would you like to play this game? (y=yes, n=no): " playAgain #ask user if they would like to play the game

    #echo $playAgain
    
    (( age = (RANDOM % 50) + 20 )) # Randomly generate a number between 20 and 70 - store in variable


    if ( [ "$playAgain" == 'n' ] ); then
        echo -e "\nGame finished.\n"
        if (( count > 0 )); then
            echo -e "Your score is $count\n"
            break
        fi
        break

    elif ( [ "$playAgain" == 'y' ] ); then
        echo -e "\nPlaying again.\n"


        while true
        do

            # Ask user to guess an age - store in ageGuess variable
             read -p "Please guess an age between 20 and 70: " userOriginalGuess


            #declare -i userGuess=userOriginalGuess
            ((userGuess=userOriginalGuess))

            if (( age > userGuess )); then
                echo -e 'Try again, your guess was to low.\n'

            elif (( age < userGuess )); then
                echo -e 'Try again, your guess was to high.\n'

            elif (( age = userGuess )); then
                echo -e '\nCORRECT!\n'
                (( count = count + 1))
                #echo 'Your score is: ' $count
                echo -e "Score = $count\n"
                break

            else
                echo -e "Invalid option. TRY AGAIN\n"
        
            fi

        done
    else
        echo -e "Invalid option. Please try again\n"

    fi

done

