#!/usr/bin/env factor
USING: kernel io math io.files io.encodings.utf8 ascii regexp sorting namespaces prettyprint sequences assocs accessors formatting html.parser html.parser.analyzer ;
IN: notes

: all-links ( url -- links ) scrape-html nip find-links ;
: html-link? ( tag -- ? ) attributes>> "href" of ".*html" <regexp> matches? ;
: html-links ( url -- links ) all-links [ first html-link? ] filter ;

: note-links ( -- links )
    "https://azimut.github.io/notes/"
    html-links
    [ second text>> >lower first ] sort-by ;

: link-href ( link-tuple -- href ) first attributes>> "href" of ;
: link-text ( link-tuple -- text ) second text>> ;

: format-html-link ( link name -- 'link )
    "<a target=\"_blank\" href=\"https://azimut.github.io/notes/%s\">%s</a>"
    sprintf ;

: note-formatted-links ( -- links )
    note-links
    [ [ link-href ] map ] [ [ link-text ] map ] bi
    [ format-html-link ] 2map ;

: main ( -- )
    "README.md" utf8 [
        [ "<div id=\"notes\">" swap index ] keep swap 3 + head
        note-formatted-links
        { "  </div>" "</div>" }
        3append
    ] change-file-lines ;

MAIN: main
