# Building a Joke-Telling AI with Microsoft's Phi-3 Mini Model

## Prompt for Generating LLM Joke Application

Create a Python notebook that demonstrates how to use the Hugging Face Transformers library to interact with Microsoft's Phi-3 Mini model. The notebook should implement a simple joke response system with the following specifications:

### Required Imports

- Import `AutoModelForCausalLM`, `AutoTokenizer`, and `pipeline` from the transformers library

- Import `GenerationConfig` from transformers

### Model Loading

- Load the "microsoft/Phi-3-mini-4k-instruct" model with these specific parameters:
  - `trust_remote_code=True` to allow execution of model-specific code
  - `device_map="cuda"` to utilize GPU acceleration
  - `torch_dtype="auto"` for automatic optimization based on hardware

### Tokenizer Setup

- Initialize the tokenizer using the same model ID: "microsoft/Phi-3-mini-4k-instruct"

### Pipeline Configuration

- Create a text generation pipeline with these exact parameters:
  - Task: "text-generation"
  - Use the model and tokenizer objects created earlier
  - `device_map="auto"` for automatic device selection
  - `max_new_tokens=500` to limit the response length
  - `return_full_text=False` to return only the generated text
  - `do_sample=False` for deterministic generation
  - `top_p=0.95` for nucleus sampling
  - `temperature=0.9` to control randomness in the output

### User Query

- Create a messages list containing a single user query: "Why did the scarecrow win an award?"

- Format it as a dictionary with "role" and "content" keys

### Response Generation

- Pass the messages to the generator pipeline to create a response

- Print the generated text from the model's output

### Documentation

- Include clear, descriptive comments for each major component and parameter

- Explain the purpose of key parameters in the pipeline configuration

The notebook should be well-structured, thoroughly commented, and ready to execute for anyone wanting to interact with the Phi-3 model.
