"""
Music notation renderer for Music Theory AI Chat.
This module provides functions to render music notation from ABC notation.
"""

import os
import tempfile
from music21 import converter, environment
import base64
from pathlib import Path

# Configure music21 environment
us = environment.UserSettings()
try:
    # Try to use MuseScore if available (better quality)
    us['musicxmlPath'] = '/usr/bin/musescore'
except:
    # Otherwise fall back to internal renderer
    pass

def render_abc_notation(abc_notation, output_dir=None):
    """
    Render ABC notation to an image file and return the path.
    
    Args:
        abc_notation (str): ABC notation string
        output_dir (str, optional): Directory to save the image. If None, uses a temporary directory.
    
    Returns:
        str: Path to the rendered image file, or None if rendering failed
    """
    try:
        if output_dir is None:
            # Use the saved_chats folder
            current_dir = os.path.dirname(os.path.abspath(__file__))
            output_dir = os.path.join(current_dir, "saved_chats")
            os.makedirs(output_dir, exist_ok=True)
        
        # Create a temporary file for the ABC notation
        with tempfile.NamedTemporaryFile(mode='w', suffix='.abc', delete=False) as temp_abc:
            temp_abc.write(abc_notation)
            temp_abc_path = temp_abc.name
        
        # Convert ABC to music21 object
        score = converter.parse(temp_abc_path)
        
        # Generate a PNG file
        image_path = os.path.join(output_dir, f"music_notation_{os.path.basename(temp_abc_path)}.png")
        score.write('musicxml.png', fp=image_path)
        
        # Clean up the temporary ABC file
        os.unlink(temp_abc_path)
        
        return image_path
    except Exception as e:
        print(f"Error rendering ABC notation: {e}")
        return None

def extract_abc_notation(text):
    """
    Extract ABC notation blocks from text.
    
    Args:
        text (str): Text containing ABC notation blocks
    
    Returns:
        list: List of ABC notation blocks
    """
    abc_blocks = []
    in_abc_block = False
    current_block = []
    
    # Look for blocks that start with X: and end with blank lines
    for line in text.split('\n'):
        if line.strip().startswith('X:') and not in_abc_block:
            in_abc_block = True
            current_block = [line]
        elif in_abc_block:
            current_block.append(line)
            if line.strip() == '':
                in_abc_block = False
                abc_blocks.append('\n'.join(current_block))
                current_block = []
    
    # Don't forget the last block if there's no trailing blank line
    if in_abc_block and current_block:
        abc_blocks.append('\n'.join(current_block))
    
    return abc_blocks

def get_abc_example(tune_type="scale"):
    """
    Get example ABC notation for different types of music elements.
    
    Args:
        tune_type (str): Type of music element to generate
    
    Returns:
        str: Example ABC notation
    """
    examples = {
        "scale": """X:1
T:C Major Scale
M:4/4
L:1/8
K:C
C D E F G A B c|]""",
        "chord": """X:1
T:Basic Chords
M:4/4
L:1/4
K:C
[CEG] [DFA] [EGB] [FAc]|]""",
        "melody": """X:1
T:Simple Melody
M:4/4
L:1/8
K:G
|: D2 G2 B2 A2 | G2 E2 E2 D2 | D2 G2 B2 A2 | G4 G4 :|"""
    }
    
    return examples.get(tune_type.lower(), examples["scale"])
