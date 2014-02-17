---
categories:
 - Linux
 - Security
---
Recursively find and chmod directories and files to allow read-only
permissions for web use: find . -type d -exec chmod 755 {} \\; find .
-type f -exec chmod 644 {} \\;

