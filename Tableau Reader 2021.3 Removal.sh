#!/bin/sh

########################################################################
# This script removes the Tableau Reader 2021.3 app and associated     #
# files and    	                                                       #
# components from the system.  										   #
#																	   #
# Created by Tony Franco on 8/6/19  Modified by C. Scalise 12/20/21    #							       
########################################################################

# Variables
appName="Tableau Reader 2021.3"
userList=$(dscl . -list /Users | grep -v _ | grep -v root | grep -v daemon | grep -v nobody | grep -v empty | grep -v Guest)
logFile="/Library/Logs/PublicisGroupe/${appName} Uninstaller.log"

# Functions
quitApp()
{
	PROC=$(ps -ax | grep "$1" | grep -v grep | grep -v Installer | awk 'NR==1{print $1}')
	echo $PROC
	if [ -n "$PROC" ]; then
		kill -9 "$PROC" > /dev/null 2>&1
	fi
}

ScriptLogging () {

    if [ ! -d "/Library/Logs/PublicisGroupe" ]; then
      mkdir "/Library/Logs/PublicisGroupe"
    fi

    DATE=`date +%Y-%m-%d\ %H:%M:%S`
    LOG="${logFile}"

    echo "$DATE" " $1" >> "$LOG"
}

if [[ -d "/Applications/${appName}.app" ]]; then
	ScriptLogging "Found the ${appName} app on the system"
	ScriptLogging "Starting the removal process"
else
	ScriptLogging "The ${appName} app was not found on the system"
	ScriptLogging "The removal process will not continue"
	exit 0
fi


# Removing Application
ScriptLogging "Removing the ${appName} app"
rm -rf "/Applications/${appName}.app" 2> /dev/null

# Removing all associated components
ScriptLogging "Removing ${appName} user preferences and components"
rm -rf "/Library/Preferences/com.tableau.Tableau-Reader-2021.3.plist" 2> /dev/null

ScriptLogging "The removal process of Tableau Reader 2021.3 has been completed "

exit 0