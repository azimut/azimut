#!/bin/bash
set -ex
sed -f - -i README.md <<EOF
/<table id="blog_entries"/,/<\/table>/ {
     /<table/b
     /<\/table>/ {
        e "./update_blog_entries.py"
        p
     }
     d
}
EOF
