# Manual GitHub Release Instructions

## Prerequisites
- Tag has been pushed to GitHub (currently v1.0.1)
- The Debian package `music-theory-ai_1.0.0_all.deb` has been created

## Steps to Create a GitHub Release

1. **Go to the GitHub repository**
   - Navigate to [https://github.com/nicokuehn-dci/muzsic-theory-ai](https://github.com/nicokuehn-dci/muzsic-theory-ai)

2. **Create a new release**
   - Click on "Releases" in the right sidebar
   - Click on "Create a new release" or "Draft a new release"

3. **Set up the release**
   - Choose the tag: `v1.0.1` (already created)
   - Title: `Music Theory AI Assistant v1.0.1`
   - Description: Add details about this release, such as:
     ```
     Music Theory AI Chat Assistant v1.0.1
     
     ## Features
     - Interactive AI chat for music theory education
     - Voice input/output capabilities
     - Music notation rendering
     - Comprehensive topic selection
     - Session saving and loading
     
     ## Improvements in v1.0.1
     - Fixed Python virtual environment creation during installation
     - Added automatic dependency installation
     - Improved error handling for missing prerequisites
     ```

4. **Add the Debian package**
   - Drag and drop the `music-theory-ai_1.0.0_all.deb` file into the "Attach binaries" section
   - Or click "Attach binaries" and select the file

5. **Finalize the release**
   - Click "Publish release"

## Post-Release

After creating the release, users can download the Debian package directly from the Releases page and install it using:

```bash
sudo apt install ./music-theory-ai_1.0.0_all.deb
```

## Testing the Debian Package

To verify the installation:

1. Install the package:
   ```bash
   sudo apt install ./music-theory-ai_1.0.0_all.deb
   ```

2. Run the application:
   ```bash
   music-theory-ai
   ```

3. The first run should prompt you for an API key if one is not already configured

4. Test the API key configuration tool:
   ```bash
   music-theory-ai-config
   ```
