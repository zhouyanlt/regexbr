# --- -------------------------------- --- #
# FUNC:  Process a folder of files
# --- -------------------------------- --- #
func_process_folder_set(){
    FOLDER="${1}"

    for filename in $FOLDER/*; do
        if [ -d $filename ]; then
            func_process_folder_set $filename
        elif [[ $filename==*".lua"* ]]; then
            echo $filename
            lua regexbr.lua $filename
        fi
    done
}

# -- call the function above with this:
func_process_folder_set $1

