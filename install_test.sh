
choice () {
    local choice=$1
    if [[ ${opts[choice]} ]] # toggle
    then
        opts[choice]=
    else
        opts[choice]=+
    fi
}

PS3='Please enter your choice: '
while :
do
    clear
        options=$(
            while IFS=: read -r f1 f2 f3 f4; do
            app=$f1 bin=$f3

                echo \""$app $f4"\"

        done < app.list
        )
        options+=\ '"Done"'

    select opt in "${options[@]}"
    do
        case $opt in
 
 
            "rigctrl ${opts[1]}") choice 1 break ;;
            "Option 2 ${opts[2]}")
                choice 2
                break
                ;;
            "Option 3 ${opts[3]}")
                choice 3
                break
                ;;
            "Option3 4 ${opts[4]}")
                choice 4
                break
                ;;
            "Done")
                break 2
                ;;
            *) printf '%s\n' 'invalid option';;
        esac
    done
done

printf '%s\n' 'Applications chosen:'
for opt in "${!opts[@]}"
do
    if [[ ${opts[opt]} ]]
    then
        printf '%s\n' "Option $opt"


    fi
done