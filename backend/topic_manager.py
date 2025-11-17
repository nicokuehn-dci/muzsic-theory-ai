"""
Function to change the current topic in the Music Theory AI Chat.
This allows switching between different specialized system prompts.
"""
# Import prompt manager to maintain state
try:
    from prompt_manager import get_current_prompt_type, set_current_prompt_type
except ImportError:
    pass

def change_topic(conversation, current_prompt_type, system_prompts):
    """
    Change the current music theory topic.
    
    Args:
        conversation (list): The current conversation history
        current_prompt_type (str): The current prompt type
        system_prompts (dict): Dictionary of available system prompts
        
    Returns:
        tuple: (new_prompt_type, boolean indicating if it changed)
    """
    from rich.console import Console
    from rich.table import Table
    import time
    
    console = Console()
    
    # Create a table for topics
    table = Table(title="Available Music Theory Topics")
    table.add_column("Option", style="cyan", justify="center")
    table.add_column("Topic", style="green")
    table.add_column("Description", style="yellow")
    
    # Add topics
    topics = {
        "1": {"id": "general", "name": "General Music Theory", "description": "General music theory and composition topics"},
        "2": {"id": "composition", "name": "Music Composition", "description": "Focused on composition techniques and practice"},
        "3": {"id": "harmony", "name": "Harmony & Analysis", "description": "Chord progressions and musical analysis"},
        "4": {"id": "ear_training", "name": "Ear Training", "description": "Developing aural skills and ear training"},
        "5": {"id": "history", "name": "Music History", "description": "Historical context and evolution of music"}
    }
    
    # Add topic rows
    for key, topic in topics.items():
        marker = "→" if topic["id"] == current_prompt_type else " "
        table.add_row(
            f"{key} {marker}", 
            topic["name"], 
            "Currently selected" if topic["id"] == current_prompt_type else topic["description"]
        )
    
    console.print(table)
    topic_choice = input("Select topic number (or press Enter to keep current): ")
    
    if topic_choice in topics:
        new_topic = topics[topic_choice]["id"]
        
        # Change the system message if the new topic is different and exists in our prompts
        if new_topic != current_prompt_type and new_topic in system_prompts:
            # Update the system message
            conversation[0]["content"] = system_prompts[new_topic]
            
            # Update the global state if possible
            try:
                set_current_prompt_type(new_topic)
            except:
                pass
                
            console.print(f"[green]Switched to topic:[/green] {topics[topic_choice]['name']}")
            console.print("[yellow]The AI will now focus on this specialized music topic.[/yellow]")
            return new_topic, True
        else:
            console.print("[yellow]Keeping current topic.[/yellow]")
            return current_prompt_type, False
    else:
        console.print("[yellow]Topic selection cancelled.[/yellow]")
        return current_prompt_type, False
