#!/usr/bin/env bash

# Name: dmwebsearch.sh
# Description: Search various search engine
# Maintainer: zagabe.ed@gmail.com

if [[ -z "${DM_WEBSEARCH_BROWSER}" ]]; then
    DM_WEBSEARCH_BROWSER="google-chrome-stable"
fi

if [[ -z "${DM_WEBSEARCH_ENGINES}" ]]; then
    DM_WEBSEARCH_ENGINES=(
        "youtube - https://youtube.com/results?search_query="
        "google - https://google.com/search?q="
        "googleimages - http://google.com/search?hl=en&tbm=isch&q="
        "github.com - https://github.com/search?q="
        "github.com/eddyzags - https://github.com/eddyzags?tab=repositories&q="
        "amazon - https://www.amazon.fr/s?k="
        "reddit - https://www.reddit.com/search/?q="
    )
fi

# Prompt to the user which web search engine to use
engine=$(printf '%s\n' "${DM_WEBSEARCH_ENGINES[@]}" | sort | dmenu -i -l 20 -p 'Choose search engine:')

#TODO(eddyzags): Need to handle error cases. (Examples: Websearch engine)

# Extract information from user input
engine_name=$(printf '%s\n' "$engine" | awk '{print $1}')
engine_url=$(printf '%s\n' "$engine" | awk '{print $NF}')

# Prompt to the user which search query to send
search_query=$(echo "specify the search query" | dmenu -i -l 20 -p "Search in $engine_name :") || exit

$DM_WEBSEARCH_BROWSER "$engine_url""$search_query"
