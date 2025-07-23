#!/usr/bin/env python3

import re
import requests

BLOG_URL = "http://azimut.github.io/blog"
LINE_START = "<li><b>"
LINE_REGEX = r"<b>(?P<date>\d{2}/\d{2})</b><a href=\"(?P<filename>.*.html)\">(?P<title>.*)</a>"

def main():
    response = requests.get(BLOG_URL)
    trs = generate_trs(response.text)
    print(trs)

def generate_trs(content: str) -> str:
    result = ""
    for line in content.splitlines():
        if not line.startswith(LINE_START): continue
        match = re.search(LINE_REGEX, line)
        if match:
            result += "<tr>"
            result += f"<td>{match.group('date')}</td>"
            result += f"<td><a target=\"_blank\" href=\"{BLOG_URL}/{match.group('filename')}\">{match.group('title')}</a></td>"
            result += "</tr>"
    return result

if __name__ == '__main__':
    main()
