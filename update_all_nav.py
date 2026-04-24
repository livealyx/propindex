import os
import re

# Read the correct nav and footer from contact.html
with open('contact.html', 'r', encoding='utf-8') as f:
    content = f.read()

head_match = re.search(r'(?s)(<head>.*?</head>)', content)
nav_match = re.search(r'(?s)(<!-- Navigation -->.*?</nav>)', content)
footer_match = re.search(r'(?s)(<!-- Footer -->.*?</footer>)', content)

if not nav_match or not footer_match or not head_match:
    print("Could not find required blocks in contact.html")
    exit(1)

nav_content = nav_match.group(1)
footer_content = footer_match.group(1)
head_template = head_match.group(1)

# we need to keep the original title
def replace_blocks(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        file_content = f.read()
    
    # Extract title from current file
    title_match = re.search(r'<title>(.*?)</title>', file_content)
    title = title_match.group(1) if title_match else "PropIndex"
    
    # Generate new head
    new_head = re.sub(r'<title>.*?</title>', f'<title>{title}</title>', head_template)
    
    # Replace head
    file_content = re.sub(r'(?s)<head>.*?</head>', new_head, file_content)
    
    # Replace nav (could be <nav>...</nav> or <!-- Navigation -->...</nav>)
    if '<!-- Navigation -->' in file_content:
        file_content = re.sub(r'(?s)<!-- Navigation -->.*?</nav>', nav_content, file_content)
    else:
        file_content = re.sub(r'(?s)<nav.*?</nav>', nav_content, file_content)
        
    # Replace footer
    if '<!-- Footer -->' in file_content:
        file_content = re.sub(r'(?s)<!-- Footer -->.*?</footer>', footer_content, file_content)
    else:
        file_content = re.sub(r'(?s)<footer.*?</footer>', footer_content, file_content)
        
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(file_content)
    print(f"Updated {filepath}")

# Process all html files
for filename in os.listdir('.'):
    if filename.endswith('.html') and filename != 'contact.html':
        try:
            replace_blocks(filename)
        except Exception as e:
            print(f"Error processing {filename}: {e}")
