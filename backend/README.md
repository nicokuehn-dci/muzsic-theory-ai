# Backend (Python)

This folder contains copies of the core Python modules for the original CLI application. They are kept here to separate backend code from the new `frontend/` React app.

You can run the backend from the project root (or from `backend/`) as before. Recommended steps:

```bash
# Create and activate a virtual environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run the CLI application
python backend/first_ai.py
```

Note: The repository still contains the original top-level Python files. These are copied into `backend/` to preserve structure; remove the originals if you want a full move.
