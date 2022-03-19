#!/bin/env bash

# Name: dmjira.sh
# Description: Perform various actions on Jira
# Maintainer: zagabe.ed@gmail.com
# Dependencies: https://www.npmjs.com/package/jira-cli

if [[ -z "${DM_JIRA_API}" ]]; then
    DM_JIRA_API="" # To declare here or as environment variable /!\
fi

DM_JIRA_BROWSER="google-chrome-stable"

DM_JIRA_ASSIGNED_ISSUES_ACTION="assigned-issues"
assigned_issues () {
    jira_cli_output=$(jira i | grep -e '[A-Z]\+-[0-9]\+' | sed 's/\\[90m//g' | sed 's/\\[39m//g')

    # Prompt to the user the assigned issue to use
    choice=$(printf '%s\n' "${jira_cli_output[@]}" | dmenu -i -l 20 -p "assigned issues") || exit

    ticket_id=$(echo $choice | grep -oe '[A-Z]\+-[0-9]\+')

    $DM_JIRA_BROWSER $DM_JIRA_API"/browse/$ticket_id"
}

DM_JIRA_SEARCH_ACTION="search"
search () {
    search_query=$(echo "specify the search query" | dmenu -i -l 20 -p "Search in jira")

    $DM_JIRA_BROWSER $DM_JIRA_API"/secure/QuickSearch.jspa?searchString=$search_query"
}

DM_JIRA_ACTIONS=(
    $DM_JIRA_ASSIGNED_ISSUES_ACTION
    $DM_JIRA_SEARCH_ACTION
)


# Prompt to the user which action to use
action=$(printf '%s\n' "${DM_JIRA_ACTIONS[@]}" | sort | dmenu -i -l 20 -p 'Select action in jira:')

case $action in
    $DM_JIRA_ASSIGNED_ISSUES_ACTION)
        assigned_issues
        ;;
    $DM_JIRA_SEARCH_ACTION)
        search
        ;;
esac
