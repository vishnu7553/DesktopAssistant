# Linux Desktop Assistant with LLM Integration

## Overview
This project introduces a Linux Desktop Assistant designed to simplify and streamline operating system operations. By leveraging a local Large Language Model (LLM), the assistant can execute Linux commands, interpret outputs, and provide user-friendly responses. It also offers a clean UI built using Streamlit, enabling users to interact seamlessly.

---

## Features
- **Natural Language Interaction**: Execute and query Linux commands using conversational prompts.
- **Secure Execution**: Safely run shell commands in a controlled environment.
- **User-Friendly Responses**: Outputs are processed and displayed in plain language for clarity.
- **Customizability**: Fine-tuned LLM tailored for Linux-specific tasks.
- **Streamlined UI**: An interactive and accessible interface built with Streamlit.

---

## Implementation
The assistant integrates the following key components:
1. **Streamlit UI**: Provides a user-friendly interface for input and output.
2. **Ollama Integration**: Interacts with the `ollama` library to leverage the LLM for generating responses.
3. **Command Execution Layer**: Uses Python's `subprocess` module to execute terminal commands securely.
4. **Message History**: Tracks user interactions to maintain conversational context.
5. **Dynamic Model Handling**: Allows seamless tool calling for advanced interactions.

---

## Prerequisites
- Linux operating system.
- Python 3.8 or later.
- Internet connection for downloading dependencies and models.

---

## Setup

### Step 1: Clone the Repository
```bash
git clone https://github.com/vishnu7553/DesktopAssistant.git
cd linux-assistant
```

### Step 2: Install Dependencies
A Makefile is provided to simplify the setup process. This will:
```bash
make setup
```

### Step 3: Run the Assistant
To start the application, run:
```bash
streamlit run src/main.py
```
### Help:
For installation help, run:
```bash
make help
```
