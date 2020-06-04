#!/bin/bash
# Megan Usher
# 10496521
# CSP2101 - Assignment 

# Video Version -- version used to record video part of assignment

# Define a function called "file_size"
function file_size(){
    # If the input is less than or equal to 1024, then set "file_size_unit" to 'KB'
    if (( $1 <= 1024 )); then
        file_size_unit='KB'
    # Else, if the input is greater then 1024 and less then 1048576, then set "file_size_unit" to 'MB'
    elif (( $1 > 1024 && $1 <= 1048576 )); then
        file_size_unit='MB'
    # Else, set the "file_size_unit" to 'GB'
    else
        file_size_unit='GB'
    fi                                                                                      # Indicates the end of the iterative statement
    # Set the "file_size_unit" to the "func_result" variable, allowing this to be called upon later on in the code
    func_result=$file_size_unit
}

# Downloads sourse code of website with the URL given in assignment brief
curl -s "https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152/" > source_code.txt

# Begins a continuous loop 
while true
do
    # Prints 5 options for the user to choose from
    echo -e "\nWhich of the following would you like to do? 
    [1] Download a specific thumbnail
    [2] Download all thumbnails
    [3] Download thumbnails in a range (using the last 4 digits)
    [4] Download a specified number of thumbnails randomly
    [5] Quit the program"
    # Asks the user to chooose one of the options that was printed -- displays ">" on a line after the options for increased readability
    read -p $'\n'"> " user_option
    # If the user selected option "1"
    if ( [ "$user_option" == "1" ] ) ; then
        # Inform the user that they have choosen to download a specific thumbnail and direct them to the website to choose which thumbnail they would like to download
        echo -e "\nYou have choosen to download a specific thumbnail.
        
        Please go to the following website and choose your tumbnail number: https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152"
        # Asks the user to input the number of the thumbnail they would like to download
        read -p $'\n'"Please insert the thumbnail number you would like to download: " user_input
        # If the user's input can be found in the "source_code" text file, then
        if ( grep -q "$user_input" source_code.txt ) ; then
            # Give the output of grep the variable grep_reply
            grep_reply="$( grep "$user_input" source_code.txt )"
            # Download the file with the user_input without disaplaying the wget downloading messages to the command line, instead, placing messages into a file "file.log" to allow headings to be isolated           
            wget -o file.log -F --no-hsts https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$user_input.jpg #> file.txt
            # Let "raw_length" variable contain the contents of "file.log", remove the "Length:" at the start of the contents, remove brackets and 3 letters/numbers within, remove "image" with any 1 character before and 6 characters after
            raw_length="$(cat file.log | grep '^Length:' file.log | sed 's/Length://' | sed 's/(...)//' | sed 's/.image......//' )"
            # Pass the "raw_length" variable through the "file_size" function
            file_size $raw_length
            # Inform the reader that the file is busy downloading
            echo -e "\nDownloading DSC0$user_input, with the file name DSC0$user_input.jpg, with a file size of $raw_length $file_size_unit -- Changed 1 element"                                                                                            
            # Inform user that the file has successfully been downloaded
            echo -e "\nFile download is complete.\nProgram Finished."
        else
            # If the file the user typed in does not exist, inform them and get them to try again.
            echo -e "\nFile does not exist. Please try again."
        fi                                                                                         # Indicates end of iterative statement
        # Remove the "file.log" file, as it is no longer needed
        rm file.log
        # Remove the "file.txt" file, as it is no longer needed
        #rm file.txt


    # If the user selected the 2nd option then
    elif ( [ "$user_option" == "2" ] ) ; then
        # If user selected the second option, then they will recieve a message informing them that the files are busy downloading.                                   
        echo -e "\n\nYou have choosen to download all thumbnails.
        
        Files Downloading... Please wait.\n\n"

        # Stores all items in the "source_code.txt" file that match ">DSC" into a file called "matches.txt", using the grep command
        grep ">DSC" source_code.txt > matches.txt

        # Locates all the words that match "DSC....." in the matches.txt file and places all values into the tumbnails.txt file. There are 5 dots as that is how long the thumbnail numbers are
        cat matches.txt | grep -Eo 'DSC.....' > thumbnails.txt

        # Goes through each line in the tumbnails.txt file 
        for line in $(cat thumbnails.txt); do
            # Download the file with the user_input without disaplaying the wget downloading messages to the command line, instead, placing messages into a file "file.log" to allow headings to be isolated           
            wget -o file.log -F --no-hsts https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/$line.jpg #> file.txt
            # Let "raw_length" variable contain the contents of "file.log", remove the "Length:" at the start of the contents, remove brackets and 3 letters/numbers within, remove "image" with any 1 character before and 6 characters after
            raw_length="$(cat file.log | grep '^Length:' file.log | sed 's/Length://' | sed 's/(...)//' | sed 's/.image......//' )"
            # Pass the "raw_length" variable through the "file_size" function
            file_size $raw_length
            # Inform the reader that the file is busy downloading
            echo -e "\nDownloading $line, with the file name $line.jpg, with a file size of $raw_length $file_size_unit"

        # "done" indicates the end of the for loop, as well as "break" indicating then end of the if statement
        done                                                                                                 # Indicates end of for loop
        # Tell the user that the files have downloaded successfully
        echo -e "\nFiles successfully downloaded."
        # Remove the "matches.txt" file as it is no longer needed
        rm matches.txt
        # Remove the "thumbnails.txt" file as it is no longer needed
        rm thumbnails.txt
        # Remove the "file.log" file as it is no longer needed
        rm file.log

    # If the user selected the 3rd option, then
    elif ( [ "$user_option" == "3" ] ) ; then
        # Tell the user that they have choosen to download thumbnails in a range using the last 4 digits of the thumbnail numbers
        echo -e "You have choosen to download thumbnails in a range, using the last 4 digits of the thumbnail numbers."
        
        # Stores all items in the "source_code.txt" file that match ">DSC" into a file called "matches.txt", using the grep command
        grep ">DSC" source_code.txt > matches.txt
        # Locates all the words that match "DSC....." in the matches.txt file and places all values into the tumbnails.txt file. There are 5 dots as that is how long the thumbnail numbers are
        cat matches.txt | grep -Eo 'DSC.....' > thumbnails.txt

        # Takes "DSC0" out of file. 
        sed -e 's/^DSC0//' thumbnails.txt > image_numbers.txt
        # Let the user see all the thumbnail number options they can choose from
        echo -e "Here is the list of thumbnail numbers you can choose from: "
        # Print to the screen the thumbnail options
        cat image_numbers.txt
        
        # Ask the user to type the last 4 digits of the starting number for the range, store in "user_start_range" variable
        read -p $'\n'"Please insert the last four digits of the starting number of the range you would like to download: " user_start_range
        # Ask the user to type the last 4 digits of the ending number for the range, store in "user_end_range" variable
        read -p $'\n'"Please insert the last four digits of the ending number of the range you would like to download: " user_end_range

        for line in $(cat image_numbers.txt); do
            # If it is below user_start_range, then don't do anything
            if (( "$line"  < "$user_start_range" )) ; then
                true
            # If it is above the user_end_range then don't do anything
            elif (( "$line" > "$user_end_range" )) ; then
                true
            # Else, move the line into the "image_numbers_remaining" text document
            else
                grep "$line" image_numbers.txt | sed '/$line/d' >> image_numbers_remaining.txt
            fi                                                                                          # Indicates the end of the iterative statement
        done                                                                                            # Indicates the end of the for loop

        ## Print results to screen saying downloading
        echo -e "\n\nFiles Downloading.... Please wait."

        # Loops through each line in the image_numbers_remaining.txt file 
        for line in $(cat image_numbers_remaining.txt); do
            # Download the file with the user_input without disaplaying the wget downloading messages to the command line, instead, placing messages into a file "file.log" to allow headings to be isolated           
            wget -o file.log -F --no-hsts https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0$line.jpg #> file.txt
            # Let "raw_length" variable contain the contents of "file.log", remove the "Length:" at the start of the contents, remove brackets and 3 letters/numbers within, remove "image" with any 1 character before and 6 characters after
            raw_length="$(cat file.log | grep '^Length:' file.log | sed 's/Length://' | sed 's/(...)//' | sed 's/.image......//' )"
            # Pass the "raw_length" variable through the "file_size" function
            file_size $raw_length
            # Inform the reader that the file is busy downloading
            echo -e "\nDownloading DSC0$line, with the file name DSC0$line.jpg, with a file size of $raw_length $file_size_unit"
        done                                                                                            # Indicates the end of the for loop
        
        # Tell user that files have been successfully downloaded
        echo -e "\nFiles successfully downloaded."
        
        # Remove "image_numbers_remaining" text file as it is no longer needed
        rm image_numbers_remaining.txt
        # Remove "image_numbers.txt" as it is no longer needed
        rm image_numbers.txt
        # Remove "thumbnails.txt" as it is no longer needed
        rm thumbnails.txt
        # Remove "matches.txt" as it is no longer needed
        rm matches.txt
        # Remove "file.log" as it is no longer needed
        rm file.log
    
    # If the user selected the 4th option, then
    elif ( [ "$user_option" == "4" ] ) ; then
        # Tells user which option they selected. And asks them to choose the number of random thumbnails they would like to download.
        echo "You have choosen to download a specific number of thumbnails randomly. 

        Please insert the number of thumbnails you would like to download (between 1 and 75): "
        # Asks the reader to input their number
        read -p $'\n'"> " user_download_num
        # Tells user that files are busy being downloaded
        echo -e "\nFile downloading... Please wait"
        # Creates an empty array --> for use further down
        numbers=()
        # Initialises the "count" variable to 0 --> for use futher down 
        (( count=0 ))
        # Starts a continuous loop
        while true
        do
            # Genarates a random number between 1 and 75 and stores it in a variable called "num"
            (( num = (RANDOM % 75) + 1 ))            
            # Adds the randomly generated number "num" to the "numbers" array
            numbers+=( "$num" )
            # Adds 1 to the count variable
            (( count = count + 1))
            # If the count variable is equal to the amount of random numbers the user would like (stored in the "user_download_num" variable)
            if [ "$count" = "$user_download_num" ] ; then
                # Then break out of this loop - as we do not need to generate any further random numbers
                break
            fi                                                                                          # Identifies the end of the if statement
        done                                                                                            # Identifies the end of the while loop
        
        # Stores all items in the "source_code.txt" file that match ">DSC" into a file called "matches.txt", using the grep command
        grep ">DSC" source_code.txt > matches.txt
        # Locates all the words that match "DSC....." in the matches.txt file and places all values into the tumbnails.txt file. There are 5 dots as that is how long the thumbnail numbers are
        cat matches.txt | grep -Eo 'DSC.....' > thumbnails.txt

        # Take "DSC0" out of file. 
        sed -e 's/^DSC0//' thumbnails.txt > image_numbers.txt
        # Takes the contents of "image_numbers" text file, and places it into a variable called "thumbnail_numbers"
        mapfile -t thumbnail_numbers < image_numbers.txt

        # For each number in the "numbers" array
        for num in ${numbers[@]} 
        do
            # Nested loop -- For each index number in "thumbnail_numbers" array
            for index in ${!thumbnail_numbers[@]} 
            do
                # If the number in "numbers" array is equal to the index of an item (number) in "thumbnail_numbers" array
                if [ $num == $index ] ; then 
                    # Download the file with the user_input without disaplaying the wget downloading messages to the command line, instead, placing messages into a file "file.log" to allow headings to be isolated           
                    wget -o file.log -F --no-hsts https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC0${thumbnail_numbers[index]}.jpg #> file.txt
                    # Let "raw_length" variable contain the contents of "file.log", remove the "Length:" at the start of the contents, remove brackets and 3 letters/numbers within, remove "image" with any 1 character before and 6 characters after
                    raw_length="$(cat file.log | grep '^Length:' file.log | sed 's/Length://' | sed 's/(...)//' | sed 's/.image......//' )"
                    # Pass the "raw_length" variable through the "file_size" function
                    file_size $raw_length
                    # Inform the reader that the file is busy downloading
                    echo -e "\nDownloading DSC0${thumbnail_numbers[index]}, with the file name DSC0${thumbnail_numbers[index]}.jpg, with a file size of $raw_length $file_size_unit"
                fi                                                                              # Indicates end of iterative statement
            done                                                                                # Indicates end of continuous loop
        done                                                                                    # Indicates end of continuous loop
        # Tells user that files have been downloaded successfully
        echo -e "\nFiles downloaded successfully."
        # Removes "thumbnail_numbers.txt" as it is no longer needed
        rm thumbnails.txt
        # Removes "image_numbers.txt" as it is no longer needed
        rm image_numbers.txt
        # Removes "matches.txt" as it is no longer needed
        rm matches.txt
        # Removes "file.log" as it is no longer needed
        rm file.log

    # If the user selected the 5th option, then
    elif ( [ "$user_option" == "5" ] ) ; then
        # Tell the user that they have choosen to quit the program
        echo -e "\nYou have chosen to quit the program.\n"
        # Break out of the loop
        break

    # If the user has typed in any other variable (or no variable at all)
    else
        # Tell them that the option they entered is not valid and they must try again
        echo -e "\nThe option you selected is not valid. Please try again."
    fi                                                                                          # Indicates end of iterative statement

done                                                                                            # Indicates end of continuous loop
# Delete the source_code text file as it is no longer necessary
rm source_code.txt

# Code Successfully Works 