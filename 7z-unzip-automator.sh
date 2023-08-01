#!/bin/bash
# auto-7z-decompress

# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Leave 
function ctrl_c() {
    echo -e "\n\n${redColour}[!]${endColour}${yellowColour} Leaving...${endColour}\n"
    exit 1
}


# Ctrl+C
trap ctrl_c INT


# Main
echo -e "${blueColour}Enter the file several times compressed:${endColour}"
read first_file_name

decompressed_file_name=$(7z l "$first_file_name" | tail -n 3 | head -n 1 | awk 'NF{print $NF}' | tr -d '\r')

echo -e "\n${blueColour}[+]${endColour}${turquoiseColour} The first file is $first_file_name, and the next file is${endColour}${purpleColour} $decompressed_file_name${endColour}"

7z x "$first_file_name" &>/dev/null

while [ "$decompressed_file_name" ]; do
    echo -e "\n${blueColour}[+]${endColour}${turquoiseColour} New file decompressed:${endColour}${purpleColour} $decompressed_file_name${endColour}"
    7z x "$decompressed_file_name" &>/dev/null
    decompressed_file_name=$(7z l "$decompressed_file_name" 2>/dev/null | tail -n 3 | head -n 1 | awk 'NF{print $NF}' | tr -d '\r')
done
