#!/bin/bash
# Megan Usher
# 10496521
# CSP2101 - Portfolio 2


while true                                                              # A continuous loop begins to ensure that the program will keep asking
do                                                                          # the user for a file path until the user provides one that is correct. 

    # Asks user to input the file path (e.g. ./user/desktop/portfolio2/rectangle.txt). Stores answer in "filePath" variable.
    read -p $'\n'"Please insert the file path for rectangle.txt: " filePath 

    if ! [ -f "$filePath" ] ; then                                      # If the file the user entered does not exist, then print a message 
        echo -e "\nFile does not exist, please try again.\n"                # to the user and ask them to try again.

    else                                                                # If the file does exist;
        echo -e "\nCreating file..."                                        # display a message to the user saying that the new file is being created.

        # This sed command goes through and deletes the first line, but contains a '\'' at the end to show that the one command is contuinuing over multiple lines to promote readability.
        sed -e '1d' $filePath\
            -e 's/^/Name: /'\
            -e 's/,/    Height: /'\
            -e 's/,/    Width: /'\
            -e 's/,/    Area: /'\
            -e 's/,/    Colour: /' > rectangle_f.txt

            # The next command places "Name: " at the beginning of each line.
            # This command replaces the first instance of a comma on each line with "Height: ".
            # This command replaces the first instance of a comma on each line with "Width: ".
            # This command replaces the first instance of a comma on each line with "Area: ".
            # This command replaces the first instance of a comma on each line with "Colour: " and proceeds to save the changed text to a file named "rectangle_f.txt".


        echo -e "\nFile created successfully.\n"                                     # The user will get a message displayed in the terminal to let them know that the file has been created successffully.
            
        break                                                           # The loop will stop, as the file has been created and there is no need for the user to be asked again for the path of the rectangle file.
    fi                                                                  # This indicates the end of the if statement.
done                                                                    # This indicates the end of the while loop. 
# End of code