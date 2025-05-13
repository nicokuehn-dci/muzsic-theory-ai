#!/usr/bin/env python3
# filepath: /home/nico-kuehn-dci/Desktop/portfolio/first_ai/compat_layer.py
"""
Compatibility layer for Python 3.13 and newer versions.
This script helps handle potential incompatibilities between different Python versions.
"""

import sys
import os
import importlib.util
import warnings

# Define features that need special handling in different Python versions
COMPAT_MODULES = {
    "json": {"fallback": None, "critical": True},
    "groq": {"fallback": None, "critical": True},
    "playsound": {"fallback": None, "critical": False},
    "pyaudio": {"fallback": None, "critical": False}
}

def is_module_available(module_name):
    """Check if a module is available without importing it."""
    return importlib.util.find_spec(module_name) is not None

def get_python_version_info():
    """Get Python version information."""
    return {
        "major": sys.version_info.major,
        "minor": sys.version_info.minor,
        "micro": sys.version_info.micro,
        "full": f"{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}"
    }

def check_compatibility():
    """Check compatibility of the current Python environment."""
    version = get_python_version_info()
    issues = []
    
    # Check for Python 3.13+ specific issues
    if version["major"] == 3 and version["minor"] >= 13:
        # Check for known problematic modules
        for module_name, options in COMPAT_MODULES.items():
            if not is_module_available(module_name):
                if options["critical"]:
                    issues.append(f"CRITICAL: Required module '{module_name}' is not available")
                else:
                    issues.append(f"WARNING: Optional module '{module_name}' is not available")
    
    return {
        "python_version": version["full"],
        "issues": issues,
        "compatible": len([i for i in issues if i.startswith("CRITICAL")]) == 0
    }

def warn_about_compatibility():
    """Print warnings about compatibility issues."""
    compat_info = check_compatibility()
    
    if compat_info["issues"]:
        warnings.warn(f"Compatibility issues detected with Python {compat_info['python_version']}:")
        for issue in compat_info["issues"]:
            warnings.warn(f"  - {issue}")
    
    return compat_info["compatible"]

# When run directly, print compatibility information
if __name__ == "__main__":
    compat_info = check_compatibility()
    print(f"Python version: {compat_info['python_version']}")
    
    if compat_info["issues"]:
        print("Compatibility issues detected:")
        for issue in compat_info["issues"]:
            print(f"  - {issue}")
    else:
        print("No compatibility issues detected.")
        
    print(f"Overall compatibility: {'OK' if compat_info['compatible'] else 'ISSUES DETECTED'}")
