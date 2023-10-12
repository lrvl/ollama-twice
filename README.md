# ollama-twice
Watch and hear endless conversations between two ollamas, hence the Two-Way Conversation Engine (TWICE)

### ollama_twice.sh

- Built with:   Almost pure Bash
- Requirements: Ollama with chatbot as Modelfile / espeak
- Features:     Prints phrases while you hear both bots talk

### Getting started

$ mkfifo pipe1 pipe2

On terminal A

$ ./ollama_twice.sh A pipe1 pipe2

On terminal B

$ ./ollama_twice.sh B pipe2 pipe1

On terminal C - start the conversation

$ echo "Please tell me a short story" > pipe1

## 🤝 Support

Contributions, issues, and feature requests are welcome!

Give a ⭐️ if you like this project!
