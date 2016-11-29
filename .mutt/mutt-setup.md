# Mutt Setup

Install the following packages on Debian-based systems:

```
mutt urlscan isync notmuch notmuch-mutt
```

The sidebar patch is included in the `mutt` package in Ubuntu 16.10.
In earlier versions of Ubuntu, it can be installed with the supplemental
`mutt-patched` package. Note that some sidebar-related options have changed in
the 16.10 version.

Set up the necessary configuration files and directories (not all of which are
included in this repository or listed here):

- .notmuch
- .mailcap
- .mbsyncrc
- .mutt/.mutt-secrets.gpg
- .mutt/aliases
- .mutt/muttrc
- .mutt/signature.txt
- .mutt/tmp/

Perform the initial mail sync: `mbsync -a`.

Create the notmuch index: `notmuch new`.

Set up cron jobs to regularly sync and backup mail.
