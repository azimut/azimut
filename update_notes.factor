#!/usr/bin/env factor
USING: kernel io math io.files io.encodings.utf8 ascii regexp random namespaces prettyprint sequences assocs accessors formatting html.parser html.parser.analyzer ;
IN: notes

CONSTANT: notes-url "https://azimut.github.io/notes/"

: find-all-links ( url -- links ) scrape-html nip find-links ;
: html-link? ( tag -- ? ) attributes>> "href" of ".*html" <regexp> matches? ;
: html-links ( url -- links ) find-all-links [ first html-link? ] filter ;

: init-random ( -- ) random-generator get 23 seed-random drop ;
: note-links ( -- links )
    init-random
    notes-url
    html-links
    randomize ;

: format-html-link ( link name -- 'link )
    "<a target=\"_blank\" href=\"" notes-url "%s\">%s</a>" 3append
    sprintf ;

: map-link-href ( link-tuple -- href ) [ first attributes>> "href" of ] map ;
: map-link-text ( link-tuple -- text ) [ second text>> ] map ;

: note-formatted-links ( -- links )
    note-links
    [ map-link-href ] [ map-link-text ] bi
    [ format-html-link ] 2map ;

: main ( -- )
    "README.md" utf8 [
        [ "<div id=\"notes\">" swap index ] keep swap 3 + head
        note-formatted-links
        { "  </div>" "</div>" }
        3append
    ] change-file-lines ;

MAIN: main
