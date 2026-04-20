#!/bin/bash
# Final Task
#   User & Group Management Menu Tool by whiptail

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (sudo)"
    exit 1
fi

while true; do
    CHOICE=$(whiptail --title "Main Menu" --menu "Select an option:" 20 80 12 \
    "Add User"          "Add a user to the system." \
    "Modify User"       "Rename an existing user." \
    "Delete User"       "Delete an existing user." \
    "List Users"        "List all real users on the system." \
    "Add Group"         "Add a user group to the system." \
    "Modify Group"      "Rename a group." \
    "Delete Group"      "Delete an existing group." \
    "List Groups"       "List all groups on the system." \
    "Disable User"      "Lock the user account." \
    "Enable User"       "Unlock the user account." \
    "Change Password"   "Change password of a user." \
    "About"             "Information about this program." 3>&1 1>&2 2>&3)

    [ $? -ne 0 ] && break

    case "$CHOICE" in

    "Add User")
        USER=$(whiptail --inputbox "Enter Username:" 10 50 "" 3>&1 1>&2 2>&3)
        if [ -n "$USER" ]; then
            if id "$USER" &>/dev/null; then
                whiptail --msgbox "User already exists!" 10 50
            else
                useradd -m "$USER" && \
                whiptail --msgbox "User $USER added successfully!" 10 50
            fi
        fi
    ;;

    "Modify User")
        USER=$(whiptail --inputbox "Enter current username:" 10 50 "" 3>&1 1>&2 2>&3)
        NEWUSER=$(whiptail --inputbox "Enter new username:" 10 50 "" 3>&1 1>&2 2>&3)

        if id "$USER" &>/dev/null; then
            if id "$NEWUSER" &>/dev/null; then
                whiptail --msgbox "New username already exists!" 10 50
            else
                usermod -l "$NEWUSER" "$USER" && \
                whiptail --msgbox "User renamed successfully!" 10 50
            fi
        else
            whiptail --msgbox "User not found!" 10 50
        fi
    ;;

    "Delete User")
        USER=$(whiptail --inputbox "Enter Username to delete:" 10 50 "" 3>&1 1>&2 2>&3)
        if id "$USER" &>/dev/null; then
            userdel -r "$USER" && \
            whiptail --msgbox "User deleted successfully!" 10 50
        else
            whiptail --msgbox "User not found!" 10 50
        fi
    ;;

    "List Users")
        USERS=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd | nl)
        whiptail --scrolltext --title "All Users" --msgbox "$USERS" 20 60
    ;;

    "Add Group")
        GROUP=$(whiptail --inputbox "Enter Group Name:" 10 50 "" 3>&1 1>&2 2>&3)
        if [ -n "$GROUP" ]; then
            if getent group "$GROUP" >/dev/null; then
                whiptail --msgbox "Group already exists!" 10 50
            else
                groupadd "$GROUP" && \
                whiptail --msgbox "Group added successfully!" 10 50
            fi
        fi
    ;;

    "Modify Group")
        OLD=$(whiptail --inputbox "Enter current group name:" 10 50 "" 3>&1 1>&2 2>&3)
        NEW=$(whiptail --inputbox "Enter new group name:" 10 50 "" 3>&1 1>&2 2>&3)

        if getent group "$OLD" >/dev/null; then
            if getent group "$NEW" >/dev/null; then
                whiptail --msgbox "New group name already exists!" 10 50
            else
                groupmod -n "$NEW" "$OLD" && \
                whiptail --msgbox "Group renamed successfully!" 10 50
            fi
        else
            whiptail --msgbox "Group not found!" 10 50
        fi
    ;;

    "Delete Group")
        GROUP=$(whiptail --inputbox "Enter Group Name to delete:" 10 50 "" 3>&1 1>&2 2>&3)
        if getent group "$GROUP" >/dev/null; then
            groupdel "$GROUP" && \
            whiptail --msgbox "Group deleted successfully!" 10 50
        else
            whiptail --msgbox "Group not found!" 10 50
        fi
    ;;

    "List Groups")
        whiptail --scrolltext --title "All Groups" --msgbox "$(cut -d: -f1 /etc/group | nl)" 20 60
            ;;

    "Disable User")
        USER=$(whiptail --inputbox "Enter Username to disable:" 10 50 "" 3>&1 1>&2 2>&3)
        if id "$USER" &>/dev/null; then
            usermod -L "$USER" && \
            whiptail --msgbox "User locked successfully!" 10 50
        else
            whiptail --msgbox "User not found!" 10 50
        fi
    ;;

    "Enable User")
        USER=$(whiptail --inputbox "Enter Username to enable:" 10 50 "" 3>&1 1>&2 2>&3)
        if id "$USER" &>/dev/null; then
            usermod -U "$USER" && \
            whiptail --msgbox "User unlocked successfully!" 10 50
        else
            whiptail --msgbox "User not found!" 10 50
        fi
    ;;

    "Change Password")
        USER=$(whiptail --inputbox "Enter Username:" 10 50 "" 3>&1 1>&2 2>&3)
        if id "$USER" &>/dev/null; then
            passwd "$USER"
        else
            whiptail --msgbox "User not found!" 10 50
        fi
    ;;

    "About")
        whiptail --msgbox "User & Group Management Tool\nUsing Bash & Whiptail\nPrepared by: Ayat Mohamed Bassiouni" 12 50
    ;;

    *)
        whiptail --msgbox "Invalid Option!" 10 50
    ;;

    esac

done

whiptail --msgbox "ALL DONE" 8 40
