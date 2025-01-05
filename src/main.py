import streamlit as st
import ollama
from typing import Dict, Any, Callable

import subprocess

def execute_command(command: str) -> str:
    """
    Executes a shell command and returns the output as a clean string.
    
    :param command: The command to be executed
    :return: The clean output of the command
    """
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        result.check_returncode()  # Raises CalledProcessError if the command failed
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return f"Command failed with error: {e}"


available_function : Dict[str,Callable] = {
    'execute_command' : execute_command,
} 


# History
if "messages" not in st.session_state:
    st.session_state["messages"] = []

# Render messages history
for message in st.session_state["messages"]:
    with st.chat_message(message["role"]):
        if message["role"] == "user" or message["role"] == "assistant":
            st.markdown(message["content"])


if prompt := st.chat_input():
    st.session_state["messages"].append({"role":"user","content":prompt})

    with st.chat_message("user"):
        st.markdown(prompt)

    with st.chat_message("assistant"):
        response = ollama.chat(
            model="Friday12:latest",
            messages=st.session_state["messages"],
            tools=[execute_command]
        )

        if response.message.tool_calls:
            for tool in response.message.tool_calls:
                if function_to_call := available_function.get(tool.function.name):
                    tool_output = function_to_call(**tool.function.arguments)
                    tool = {
                        "function_name" : tool.function.name,
                        "function_argumnts" : tool.function.arguments,
                        "function_output" : tool_output
                    }
                    st.session_state["messages"].append({"role":"tool","content":tool_output})
                    summary_response = ollama.chat(
                        model="Friday12:latest",
                        messages=st.session_state["messages"],
                    )
                    st.markdown(summary_response['message']['content'].strip())

                else:
                    print("function not found")

        else:
            response = response["message"]["content"]
            st.session_state["messages"].append({"role":"assistant","content":prompt})
            st.markdown(response)
