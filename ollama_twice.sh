#!/bin/bash

# Function to vocalize and display phrase-by-phrase
speak_and_display() {
    local voice="$1"
    local msg="$2"

    # Split on comma or period
    OLD_IFS="$IFS"
    IFS=$'\n'
    mapfile -t phrases < <(echo "$msg" | sed 's/\([,.]\)/\1\n/g')
    IFS="$OLD_IFS"

    for phrase in "${phrases[@]}"; do
        # Trim leading and trailing whitespace
        trimmed_phrase=$(echo "$phrase" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
        
        # Check if it's not empty after trimming
        if [ -n "$trimmed_phrase" ]; then
            echo -n "$trimmed_phrase" # Display the phrase
            espeak -v "$voice" "$trimmed_phrase" # Vocalize phrase
        fi
    done
    echo # Add a newline at the end of the message
}

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 BOT_NAME input_pipe output_pipe"
    echo " For example:"
    echo " On shell 1 $ ./ollama_twice.sh A pipe1 pipe2 modelnameA"
    echo " On shell 2 $ ./ollama_twice.sh B pipe2 pipe1 modelnameB"
    echo " Start the conversation with: $ echo "Please tell me a very short story" > pipe1"
    exit 1
fi

BOT_NAME="$1"
INPUT_PIPE="$2"
OUTPUT_PIPE="$3"
MODEL_NAME="$4"

# Sanity check to ensure the ollama model is available
if ! ollama show --modelfile "$MODEL_NAME" >/dev/null; then
    echo "Error: Invalid or inaccessible model: $MODEL_NAME" >&2
    exit 1
fi

VOICE_BOT_A="en-us+f3"
VOICE_BOT_B="en-uk+m3"

while true; do
    if read -r -t 10 MESSAGE < "$INPUT_PIPE"; then
        if [ -z "$MESSAGE" ]; then
            echo "Timeout or no data received." >&2
            exit 1
        fi

        # Strip any existing prefix
        CLEAN_MESSAGE="${MESSAGE#*: }"

        # Decide which voice to use based on the BOT_NAME and display and vocalize the message
        if [[ "$BOT_NAME" == "A" && "$MESSAGE" != A:* ]]; then
            speak_and_display $VOICE_BOT_A "$CLEAN_MESSAGE"
        elif [[ "$BOT_NAME" == "B" && "$MESSAGE" != B:* ]]; then
            speak_and_display $VOICE_BOT_B "$CLEAN_MESSAGE"
        fi

        RESPONSE=$(ollama run "$MODEL_NAME" "$CLEAN_MESSAGE")

        # Prefix the response with the BOT_NAME
        echo "$BOT_NAME: $RESPONSE" > "$OUTPUT_PIPE"
    else
        echo "Timeout or no data received." >&2
        exit 1
    fi
done
