#! /usr/bin/bash


# Change line endings to unix style.
dos2unix -q $1


# Insert prolog into the output file
echo "# abook addressbook file" > tmp01
echo ""                         >> tmp01
echo "[format]"                 >> tmp01
echo "program=abook"            >> tmp01
echo "version=0.6.1"            >> tmp01
echo ""                         >> tmp01
echo ""                         >> tmp01


# Remove "item[0-9]\." from the beginning of lines.
# For some reason some lines start like that. It has to be removed, because
# some EMAIL lines start like that as well.
cat $1 | sed 's/^item[0-9]\+\.//' > tmp02


# Put every vcard object on one line.
cat tmp02 | tr '\n' ' ' | sed 's/BEGIN:VCARD //g; s/END:VCARD /\n/g' > tmp03


# Remove lines without a (vcard) EMAIL tag as they are not interesting for an
# addressbook that is used for Neomutt.
cat tmp03 | sed -n '/EMAIL/p' > tmp04


# Look for the (vcard) FN tag and replace it with "name=".
# Remove everything before FN, but leave the rest of the line alone.
cat tmp04 | sed 's/.\+ FN:\(.\+\) \(\S\?\S:.\+\)/name=\1<NAME_END>\2/g' > tmp05


# Look for the (vcard) EMAIL tag and replace it with "email=".
cat tmp05 | sed 's/EMAIL;\S\+:\(\S\+\)/email=\1<EMAIL_END>/g' > tmp06


# Remove multiple "email=" markers.
# People with more than one email address have multiple "email=" marker, but
# they should just have one and the email addresses should be separated by a
# ",".
cat tmp06 | sed 's/<EMAIL_END> email=/,/g' > tmp07


# Clean up between <NAME_END> and "email=".
cat tmp07 | sed 's/\(<NAME_END>\).\+\(email=\)/\1\2/g' > tmp08


# Remove stuff after the <EMAIL_END> marker.
cat tmp08 | sed 's/\(<EMAIL_END>\).\+/\1/g' > tmp09


# Split up the contacts into the abook format.
cat tmp09 | sed '=' \
          | sed -e 's/^\([0-9]\+\)/[\1]/' \
                -e 's/<NAME_END>/\n/' \
                -e 's/<EMAIL_END>/\n/' > tmp10


# Concatenate the beginning of the file with the contacts.
cat tmp01 tmp10 > $2


# Clean up (remove all the tmp files).
rm tmp*

