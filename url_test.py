import re

def extract_urls(text):
    url_pattern = r'(https?://[^\s]+)'
    return re.findall(url_pattern, text)

# Test with a sample text
sample_text = "Here's a link to Google: https://www.google.com and another to GitHub: https://github.com"
urls = extract_urls(sample_text)
print("Found URLs:", urls)
