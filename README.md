gothub
======

*This is a fork of [aktau/github-release](https://github.com/aktau/github-release) with
a few tweaks. All the original credit should go directly to Nicolas Hillegeer :)*

A small commandline app written in Go that allows you to easily create
and delete releases of your projects on Github. In addition it allows
you to attach files to those releases.

It interacts with the [github releases API](http://developer.github.com/v3/repos/releases).
Though it's entirely possibly to [do all these things with
cURL](https://github.com/blog/1645-releases-api-preview), It's not
really that user-friendly. For example, you need to first query the API
to find the id of the release you want, before you can upload an
artifact. `gothub` takes care of those little details.

It might still be a bit rough around the edges, pull requests are
welcome!

**NOTE**: I've been made aware of the existence of the
[gothub](https://github.com/itchio/gothub) fork. Since I have very little
time to work on the project and have been a really bad maintainer, I suggest
checking it out to see if your issues have been solved there.

How to install
==============

If/when you have Go installed, you can just do:

```sh
go get github.com/itchio/gothub
```

This will automatically download, compile and install the app.

After that you should have a `gothub` executable in your
`$GOPATH/bin`.

How to use
==========

**NOTE**: for these examples I've [created a github
token](https://help.github.com/articles/creating-an-access-token-for-command-line-use)
and set it as the env variable `GITHUB_TOKEN`. `gothub` will
automatically pick it up from the environment so that you don't have to
pass it as an argument.

```sh
# set your token
export GITHUB_TOKEN=...

# check the help
$ gothub --help

# make your tag and upload
$ git tag ... && git push --tags

# check the current tags and existing releases of the repo
$ gothub info -u aktau -r gofinance
git tags:
- v0.1.0 (commit: https://api.github.com/repos/aktau/gofinance/commits/f562727ce83ce8971a8569a1879219e41d56a756)
releases:
- v0.1.0, name: 'hoary ungar', description: 'something something dark side 2', id: 166740, tagged: 29/01/2014 at 14:27, published: 30/01/2014 at 16:20, draft: ✔, prerelease: ✗
  - artifact: github.go, downloads: 0, state: uploaded, type: application/octet-stream, size: 1.9KB, id: 68616

# create a formal release
$ gothub release \
    --user aktau \
    --repo gofinance \
    --tag v0.1.0 \
    --name "the wolf of source street" \
    --description "Not a movie, contrary to popular opinion. Still, my first release!" \
    --pre-release

# you've made a mistake, but you can edit the release without
# having to delete it first (this also means you can edit without having
# to upload your files again)
$ gothub edit \
    --user aktau \
    --repo gofinance \
    --tag v0.1.0 \
    --name "Highlander II: The Quickening" \
    --description "This is the actual description!"

# upload a file, for example the OSX/AMD64 binary of aktau's gofinance app
$ gothub upload \
    --user aktau \
    --repo gofinance \
    --tag v0.1.0 \
    --name "gofinance-osx-amd64" \
    --file bin/darwin/amd64/gofinance

# upload other files...
$ gothub upload ...

# you're not happy with it, so delete it
$ gothub delete \
    --user aktau \
    --repo gofinance \
    --tag v0.1.0
```

Sometimes (too often), Github uploads fail with HTTP code 422. You can use the
`-R` or `--replace` flag to delete any previous upload (failed or not) with the
exact same name in a release

```sh
# re-upload a file, we mean it this time!
$ gothub upload \
    --user aktau \
    --repo gofinance \
    --tag v0.1.0 \
    --name "gofinance-osx-amd64" \
    --file bin/darwin/amd64/gofinance \
    --replace
```

GitHub Enterprise Support
=========================
You can point to a different GitHub API endpoint via the environment variable ```GITHUB_API```:

```
export GITHUB_API=http://github.company.com/api/v3
```

Used libraries
==============

| Package                                                                    | Description         | License |
| ------------------------------------------------------------------------   | ------------------- | ------- |
| [github.com/dustin/go-humanize](https://github.com/dustin/go-humanize)     | humanize file sizes | MIT     |
| [github.com/tomnomnom/linkheader](https://github.com/tomnomnom/linkheader) | GH API pagination   | MIT     |
| [github.com/voxelbrain/goptions](https://github.com/voxelbrain/goptions)   | option parsing      | BSD     |

Copyright
=========

Copyright (c) 2016, Amos Wenger & the itch.io team. All rights reserved.

Copyright (c) 2014, Nicolas Hillegeer. All rights reserved.

