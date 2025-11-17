"""
Prompt type manager for Music Theory AI Chat.
Handles global prompt type changes.
"""

# Current prompt type 
CURRENT_PROMPT_TYPE = "general"

def get_current_prompt_type():
    """Get the current prompt type."""
    global CURRENT_PROMPT_TYPE
    return CURRENT_PROMPT_TYPE

def set_current_prompt_type(prompt_type):
    """Set the current prompt type."""
    global CURRENT_PROMPT_TYPE
    CURRENT_PROMPT_TYPE = prompt_type
    return CURRENT_PROMPT_TYPE
