#!/usr/bin/env bash

## Util Methods:
function displayMessage() {
    whiptail --title "$1" --msgbox "$2" 8 78
}



function main() {
while true; do
        demo=$(whiptail --title "Whiptail Demo" --ok-button "Select" --cancel-button "Quit" --menu "Select a demo" 20 78 10 \
            "1" "Message Box" \
            "2" "Yes/No Box" \
            "3" "Input Box" \
            "4" "Password Box" \
            "5" "Text Box" \
            "6" "Menu" \
            "7" "Checklist" \
            "8" "Radio List" \
            "9" "Progress Gauge" \
            3>&1 1>&2 2>&3)

        exitstatus=$?

        if [ ${exitstatus} = 0 ]; then
            case ${demo} in
                1)
                    messageBoxDemo
                ;;
                2)
                    yesNoDemo
                ;;
                3)
                    inputBoxDemo
                ;;
                4)
                    passwordDemo

                ;;
                5)
                    textBoxDemo
                ;;
                6)
                    menuDemo
                ;;
                7)
                    checkListDemo
                ;;
                8)
                    radioListDemo
                ;;
                9)
                    progressGuageDemo
                ;;

            esac
        else
            exit
        fi
    done
}

function messageBoxDemo() {
    whiptail --title "Message Box Demo" --msgbox "This is an example of a message box. You must hit OK to continue." 8 78
}


function inputBoxDemo() {
    COLOR=$(whiptail --inputbox "What is your favorite Color?" 8 78 Blue --title "Example Dialog" 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ ${exitstatus} = 0 ]; then
        whiptail --title "Input Box Results" --msgbox "You selected Ok and entered ${COLOR}" 8 78
    else
        whiptail --title "Input Box Results" --msgbox "You selected Cancel" 8 78
    fi
}

function yesNoDemo() {

    if (whiptail --title "Yes/No Demo" --yesno "This is an example of a yes/no box." 8 78) then
        displayMessage "Yes/No Box Results" "User selected Yes, exit status was $?"
    else
        displayMessage "Yes/No Box Results" "User selected No, exit status was $?"
    fi
}


function passwordDemo() {
    PASSWORD=$(whiptail --title "Password Demo" --passwordbox "Please enter your secret password" 8 78 3>&1 1>&2 2>&3)

    displayMessage "Password Box Results" "Your password is: ${PASSWORD}"
}

function textBoxDemo() {
    whiptail --textbox sample.txt 12 80 --scrolltext
}


function menuDemo() {
    displayMessage "Menu Box Results" "You were indeed looking at one!"

}

function checkListDemo() {
    TOPPINGS=$(whiptail --title "Check list Demo" --checklist \
        "Choose your toppings:" 20 78 8 \
            "PINEAPPLE" "Pineapple" ON \
            "JALAPENO" "Jalapenõ" OFF \
            "OLIVES" "Olives" ON \
            "MUSHROOMS" "Mushrooms" OFF \
            3>&1 1>&2 2>&3)

    displayMessage "Checklist Results" "You selected ${TOPPINGS}"

}

function radioListDemo() {
    TOPPINGS=$(whiptail --title "Check list Demo" --radiolist \
        "Choose your toppings:" 20 78 8 \
            "PINEAPPLE" "Pineapple" ON \
            "JALAPENO" "Jalapenõ" OFF \
            "OLIVES" "Olives" OFF \
            "MUSHROOMS" "Mushrooms" OFF \
            3>&1 1>&2 2>&3)

    displayMessage "Checklist Results" "You selected ${TOPPINGS}"

}

function progressGuageDemo() {
    {
        for ((i = 0 ; i <= 100 ; i+=5)); do
            sleep 0.1
            echo $i
        done
    } | whiptail --gauge "Please wait while we are sleeping..." 6 50 0

}

main








#whiptail --title "Check list example" --checklist \
#"Choose user's permissions" 20 78 4 \
#"NET_OUTBOUND" "Allow connections to other hosts" ON \
#"NET_INBOUND" "Allow connections from other hosts" OFF \
#"LOCAL_MOUNT" "Allow mounting of local devices" OFF \
#"REMOTE_MOUNT" "Allow mounting of remote devices" OFF
#
#
#{
#    for ((i = 0 ; i <= 100 ; i+=5)); do
#        sleep .1
#        echo $i
#    done
#} | whiptail --gauge "Please wait while we are sleeping..." 6 50 0
