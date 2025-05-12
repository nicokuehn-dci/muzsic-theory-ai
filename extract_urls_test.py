import re
from rich.console import Console

console = Console()

def extract_urls(text):
    url_pattern = r'(https?://[^\s]+)'
    return re.findall(url_pattern, text)

def format_with_clickable_links(text):
    url_pattern = r'(https?://[^\s]+)'
    
    # Replace URLs with rich formatted links
    def replace_with_link(match):
        url = match.group(1)
        return f"[bold blue][link={url}]{url}[/link][/bold blue]"
    
    return re.sub(url_pattern, replace_with_link, text)

# Test with a sample text containing URLs
sample_text = """
Here's a link to Google: https://www.google.com
And here's another one to GitHub: https://github.com
"""

console.print("Original text:")
console.print(sample_text)

console.print("\nExtracted URLs:")
urls = extract_urls(sample_text)
for i, url in enumerate(urls, 1):
    console.print(f"[bold blue][link={url}]{i}. {url}[/link][/bold blue]")

console.print("\nText with clickable links:")
formatted_text = format_with_clickable_links(sample_text)
console.print(formatted_text)
