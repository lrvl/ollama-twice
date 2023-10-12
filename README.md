# ollama-twice
Watch and hear endless conversations between two ollamas, hence the Two-Way Conversation Engine (TWICE)

Ever wondered what an endless dialogue between two AI chatbots would sound like? Well, now you can not only witness it but also listen to their ongoing banter, thanks to the Two-Way Conversation Engine (TWICE).

Introducing ollama_twice.sh - A minimalist yet captivating setup where two bots, let's call them Ollama A and Ollama B, engage in eternal conversation.

Technical Highlights:

    Simplicity: Crafted with almost pure Bash scripting, keeping it lightweight and easy to grasp.
    Vocal: Uses espeak to vocalize the bots' conversation, allowing you to hear their exchange.
    Visual: Concurrently prints the conversation, ensuring you don’t miss out on the witty back-and-forths.

Have fun!

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
