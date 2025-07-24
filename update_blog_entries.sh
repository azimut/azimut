#!/bin/bash
set -ex
entries="$(python3 update_blog_entries.py)"
sed -f - -i README.md <<EOF
/<table id="blog_entries"/,/<\/table>/ {
     /<table/b
     /<\/table>/ {
        i ${entries}
        p
     }
     d
}
EOF
