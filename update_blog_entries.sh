#!/bin/bash
set -ex
entries="$(curl -s https://azimut.github.io/blog/ | grep '<li><b>' | tr -d '\n')"
sed -f - -i README.md <<EOF
/<ul class="blog-entries">/,/<\/ul>/ {
     /<ul/b
     /<\/ul>/ {
        i ${entries}
        p
     }
     d
}
EOF
