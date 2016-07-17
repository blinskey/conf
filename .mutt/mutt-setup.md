# Mutt Setup

Install the following packages on Debian-based systems:

```
mutt mutt-patched urlscan isync notmuch notmuch-mutt
```

Arrange the necessary configuration files and directories, not all of which are
included in this repository:

- .notmuch
- .mailcap
- .mbsyncrc
- .mutt/.mutt-secrets.gpg
- .mutt/aliases
- .mutt/muttrc
- .mutt/signature.txt
- .mutt/tmp

Perform the initial mail sync: `mbsync -a`.

Create the notmuch index: `notmuch new`.

Set up cron jobs to regularly sync and backup mail.
