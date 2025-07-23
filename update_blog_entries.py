#!/usr/bin/env python3

import re
import requests

BLOG_URL = "http://azimut.github.io/blog"
LINE_START = "<li><b>"
LINE_REGEX = r"<b>(?P<date>\d{2}/\d{2})</b><a href=\"(?P<filename>.*.html)\">(?P<title>.*)</a>"

def main():
    response = requests.get(BLOG_URL)
    parse(response.text)

def parse(content):
    for line in content.splitlines():
        if not line.startswith(LINE_START): continue
        match = re.search(LINE_REGEX, line)
        if match:
            print("<tr>")
            print(f"<td>{match.group('date')}</td>")
            print(f"<td><a href=\"{BLOG_URL}/{match.group('filename')}\">{match.group('title')}</a></td>")
            print("</tr>")

if __name__ == '__main__':
    main()
