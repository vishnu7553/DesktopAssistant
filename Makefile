# Define variables
VENV_DIR = LDA-venv
PYTHON = python3
PIP = $(VENV_DIR)/bin/pip
OLLAMA_MODEL = llama3.2:3b
CUSTOM_MODEL = DesktopAssistant

# Default target
all: setup

# Step 1: Python Environment Setup
python-setup:
	@echo "Creating Python virtual environment in $(VENV_DIR)..."
	$(PYTHON) -m venv $(VENV_DIR)
	@echo "Virtual environment created!"
	@echo "Installing required Python packages..."
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	@echo "Python dependencies installed successfully!"

# Step 2: Ollama Installation
ollama-install:
	@echo "Installing Ollama..."
	curl -sSfL https://ollama.com/download | sh
	@echo "Ollama installed successfully!"

# Step 3: Ollama Model Setup
ollama-model:
	@echo "Downloading and setting up the Llama model ($(OLLAMA_MODEL))..."
	ollama pull $(OLLAMA_MODEL)
	@echo "Creating custom model ($(CUSTOM_MODEL)) using the provided modelfile..."
	ollama create $(CUSTOM_MODEL) --file model/modelfile  
	@echo "Custom model $(CUSTOM_MODEL) created successfully!"

# Combine all setup steps
setup: python-setup ollama-install ollama-model
	@echo "Project setup completed successfully!"

# Cleanup with confirmation prompt
clean:
	@read -p "This will remove the virtual environment and all Ollama models downloaded by this program. Are you sure? [y/N]: " CONFIRM && \
	if [ "$$CONFIRM" = "y" ]; then \
		echo "Removing virtual environment..."; \
		rm -rf $(VENV_DIR); \
		echo "Removing Ollama models..."; \
		ollama delete $(CUSTOM_MODEL); \
		ollama delete $(OLLAMA_MODEL); \
		echo "Cleanup completed successfully!"; \
	else \
		echo "Cleanup aborted."; \
	fi

# Help command for guidance
help:
	@echo "Makefile Commands:"
	@echo "  make setup       - Set up the Python environment, install Ollama, and create the custom model"
	@echo "  make clean       - Remove the virtual environment and Ollama models (with confirmation)"
	@echo "  make help        - Display this help message"
