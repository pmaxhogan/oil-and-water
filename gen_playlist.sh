#!/bin/bash

echo > diff.m3u

git diff --name-only --cached music/ | while read i; do
    echo -n N:\\PIONEER\\ >> diff.m3u;
    echo "$i" | sed 's/\//\\/g' >> diff.m3u;
done
