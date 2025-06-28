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

# === Colors (Optional: define them or remove if not needed) ===
YLW='\033[1;33m'
BLU='\033[1;34m'
NC='\033[0m' # No Color

# === Inputs ===
read -p "Enter the target domain (e.g., example.com): " target
results_dir="./results"
mkdir -p "$results_dir/Google-dorks"

# === Dork List ===
printf "$YLW"
echo -e "\n\n*================{ Google-dorks }===================*\n\n"
base_dork=(
"[*] Open Redirect"
"https://www.google.com/search?q=site:targetdomain inurl:redir | inurl:url | inurl:redirect | inurl:return | inurl:src=http | inurl:r=http"
"[*] robots.txt"
"https://www.google.com/search?q=targetdomain+robots.txt"
"[*] Hunt for Password Files"
"https://www.google.com/search?q=site:targetdomain 'password' filetype:doc | filetype:pdf | filetype:docx | filetype:xls | filetype:dat | filetype:log"
"[*] Directory Listing"
"https://www.google.com/search?q=site:targetdomain intitle:index.of | 'parent directory'"
"[*] Database Dork"
"https://www.google.com/search?q=site:targetdomain intext:'sql syntax near' | intext:'syntax error has occurred' | intext:'incorrect syntax near' | intext:'unexpected end of SQL command' | intext:'Warning: mysql_connect()' | intext:'Warning: mysql_query()' | intext:'Warning: pg_connect()' | filetype:sql | ext:sql | ext:dbf | ext:mdb"
"[*] Config and Log Files"
"https://www.google.com/search?q=site:targetdomain ext:xml | ext:conf | ext:cnf | ext:reg | ext:inf | ext:rdp | ext:cfg | ext:txt | ext:ora | ext:ini | ext:log"
"[*] Backup Files"
"https://www.google.com/search?q=site:targetdomain ext:bkf | ext:bkp | ext:bak | ext:old | ext:backup"
"[*] Login Pages"
"https://www.google.com/search?q=site:targetdomain inurl:login | inurl:signin | intitle:Login | intitle:signin | inurl:auth"
"[*] PHP Info"
"https://www.google.com/search?q=site:targetdomain ext:php intitle:phpinfo 'published by the PHP Group'"
"[*] GitHub Dork"
"https://github.com/search?q=targetdomain"
"[*] Subdomain Enumeration Dork"
"https://www.google.com/search?q=site:*.targetdomain"
"[*] Reverse IP Lookup"
"https://viewdns.info/reverseip/?host=targetdomain&t=1"
"[*] cert.sh Check"
"https://crt.sh/?q=targetdomain"
"[*] AWS S3 Buckets"
"https://www.google.com/search?q=site:.s3.amazonaws.com 'targetdomain'"
"[*] StackOverflow Dork"
"https://www.google.com/search?q=site:stackoverflow.com 'targetdomain'"
"[*] Pastebin Lookup"
"https://www.google.com/search?q=site:pastebin.com | site:paste2.org | site:pastehtml.com | site:slexy.org | site:snipplr.com | site:snipt.net | site:textsnip.com | site:bitpaste.app | site:justpaste.it | site:heypasteit.com | site:hastebin.com | site:dpaste.org | site:dpaste.com | site:codepad.org | site:jsitor.com | site:codepen.io | site:jsfiddle.net | site:dotnetfiddle.net | site:phpfiddle.org | site:ide.geeksforgeeks.org | site:repl.it | site:ideone.com | site:paste.debian.net | site:paste.org | site:paste.org.ru | site:codebeautify.org | site:codeshare.io | site:trello.com 'targetdomain'"
"[*] WhatCMS Check"
"https://whatcms.org/?s=targetdomain"
"[*] WP-Content Dork"
"https://www.google.com/search?q=site:targetdomain inurl:wp- | inurl:wp-content | inurl:plugins | inurl:uploads | inurl:themes | inurl:download"
"[*] Web Archive"
"http://wwwb-dedup.us.archive.org:8083/cdx/search?url=targetdomain/&matchType=domain&collapse=digest&output=text&fl=original,timestamp&filter=urlkey:.*wp[-].*&limit=1000000&xx="
"[*] WordPress Deep Search"
"https://www.google.com/search?q=site:targetdomain inurl:php?=id1 | inurl:index.php?id= | inurl:pageid= | inurl:.php?"
"[*] SSL Server Test"
"https://www.ssllabs.com/ssltest/analyze.html?d=targetdomain"
"[*] Wayback Machine"
"https://web.archive.org/web/*/targetdomain/*"
"[*] SHODAN Search"
"https://www.shodan.io/search?query=targetdomain"
"[*] Search in grep.app"
"https://grep.app/search?q=targetdomain"
"[*] Security Headers"
"https://securityheaders.com/?q=targetdomain&followRedirects=on"
)

# === Generate Dorks ===
printf "$BLU"
output_file="$results_dir/Google-dorks/google-dorks.txt"
> "$output_file"

counter=0
for dork in "${base_dork[@]}"; do
  new_dork=$(echo "$dork" | sed "s/targetdomain/$target/g")
  echo "$new_dork" >> "$output_file"
  counter=$((counter+1))
  if [ $((counter % 2)) -eq 0 ]; then
    echo "" >> "$output_file"
  fi
done

echo -e "$NC"
cat "$output_file"
