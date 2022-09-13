# vcard2abook

I want to use abook as my address book for Neomutt. The problem is that I
manage all my contacts in my google account (I know, shame on me). The vcard
file that I can export from google contains all my contacts as a consecutive
list of vcard objects. The vcard2abook script converts the vcard file from
google into an addressbook file for abook.

The exported file from google looks something like this:
```bash
BEGIN:VCARD
VERSION:3.0
FN:Max Mustermann
N:Mustermann;Max;;;
EMAIL;TYPE=INTERNET;TYPE=HOME:max.mustermann@example.com
TEL;TYPE=CELL:+123456789
BDAY:19900101
CATEGORIES:myContacts
END:VCARD
BEGIN:VCARD
VERSION:3.0
FN:Erika Mustermann
N:Mustermann;Erika;;;
EMAIL;TYPE=INTERNET;TYPE=WORK:erika.mustermann@example.com
CATEGORIES:myContacts
END:VCARD
```

Running:
```bash
vcard2abook /path/to/google/export/file /path/to/output/file
```
yields an **addressbook** file that looks like this:
```
# abook addressbook file

[format]
program=abook
version=0.6.1


[1]
name=Max Mustermann
email=max.mustermann@example.com

[2]
name=Erika Mustermann
email=erika.mustermann@example.com

```

**Note:** The script only cares for the name and the email address(es) of my
contacts. All the other information is not needed in Neomutt. Therefore
everything else is discarded.

**Note:** I don't know if using `sed` this extensively is the best way to
solve the problem that I wanted to solve. But I wanted to practice my `sed`
skills while working on this.

