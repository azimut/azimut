#!/usr/bin/env -S sed README.md -i -f

/<table id="blog_entries"/,/<\/table>/ {
    /<table/b
    /<\/table>/ {
        e "./update_blog_entries.py"
        p
    }
    d
}
