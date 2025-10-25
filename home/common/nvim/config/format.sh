#!/bin/sh

if [ "$1" == "--check" ]; then
	stylua "$1" --glob "**/**.lua" --call-parentheses "NoSingleTable" --column-width "100" -- .
else
	stylua --glob "**/**.lua" --call-parentheses "NoSingleTable" --column-width "100" -- .
fi
