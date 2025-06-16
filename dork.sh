#!/bin/bash

# === ASCII Banner ===
clear
cat << 'EOF'
======================================================
 ___           _             _   _             _            
|_ _|_ __   __| | _____  __ | | | |_   _ _ __ | |_ ___ _ __ 
 | || '_ \ / _` |/ _ \ \/ / | |_| | | | | '_ \| __/ _ \ '__|
 | || | | | (_| |  __/>  <  |  _  | |_| | | | | ||  __/ |   
|___|_| |_|\__,_|\___/_/\_\ |_| |_|\__,_|_| |_|\__\___|_|       
      
        Google Dork generator – Index Hunter     
======================================================
        By: KaliyugH4cker-Ashwatthama  
EOF

echo ""
echo "== Google Dork Generator using Local Wordlist =="
echo ""

# --- Input Domain
read -p "Enter the target domain (e.g. example.com): " DOMAIN
if [[ -z "$DOMAIN" ]]; then
    echo "❌ No domain entered. Exiting."
    exit 1
fi

# --- Input Wordlist File
read -p "Enter path to dork wordlist (e.g. dorks.txt): " WORDLIST

if [[ ! -f "$WORDLIST" ]]; then
    echo "❌ Wordlist not found: $WORDLIST"
    echo "📁 Current directory: $(pwd)"
    echo "📄 Available files:"
    ls -1
    exit 1
fi

# === Output File Setup ===
OUTPUT_FILE="${DOMAIN//./_}_dorks.txt"
> "$OUTPUT_FILE"  # clear/create file

# === Generate Dorks ===
echo ""
echo "📄 Generating Google Dorks for: $DOMAIN"
echo "----------------------------------------"

COUNT=1
while IFS= read -r DORK; do
    [[ -z "$DORK" ]] && continue  # skip blank lines
    FINAL_DORK="site:$DOMAIN $DORK"
    echo "$COUNT. $FINAL_DORK"
    echo "$FINAL_DORK" >> "$OUTPUT_FILE"
    ((COUNT++))
done < "$WORDLIST"

# === Save Confirmation ===
echo ""
echo "✅ All dorks saved to: $OUTPUT_FILE"

# === Ask to Open in Browser ===
read -p "Do you want to open each dork in browser? (y/n): " OPEN
if [[ "$OPEN" =~ ^[Yy]$ ]]; then
    while IFS= read -r line; do
        SEARCH_QUERY=$(echo "$line" | sed 's/ /+/g')
        xdg-open "https://www.google.com/search?q=$SEARCH_QUERY" >/dev/null 2>&1
        sleep 1
    done < "$OUTPUT_FILE"
fi
