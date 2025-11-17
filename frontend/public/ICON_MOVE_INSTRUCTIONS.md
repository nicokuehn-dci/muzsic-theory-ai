Icon.jpeg move
----------------

I attempted to move `Icon.jpeg` into `frontend/public/` but the environment's shell filesystem provider was unavailable. Please move the file manually with one of the commands below, or run them in your local shell/CI environment.

To move and set exec permissions for scripts, run:

```bash
mkdir -p frontend/public
git mv Icon.jpeg frontend/public/Icon.jpeg
chmod +x scripts/*.sh
chmod +x *.sh
```

If you cannot use `git mv`, you can copy and remove:

```bash
mkdir -p frontend/public
cp Icon.jpeg frontend/public/Icon.jpeg
rm Icon.jpeg
chmod +x scripts/*.sh
chmod +x *.sh
```

Once moved, you can remove this file.
