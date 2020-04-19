+++
title = "Using org-mode to blog"
date = 2020-04-12
lastmod = 2020-04-12T16:11:16-05:00
draft = false
weight = 2001
+++

As I've made my way deeper into the emacs rabbit hole I stumbled upon a package
called ox-hugo that allows you to use .org files to manage content for a hugo
blog. I've toyed with the idea of moving it over the past few months, only now
getting the infrastructure in place to make it reality as this blog is now
managed with ox-hugo. It's a great choice if you already are familiar with
org-mode and emacs.

Fortunately the package is included as an option with [doom-emacs](https://github.com/hlissner/doom-emacs).
It is simple as adding,

```lisp
(org
 +hugo)
```

to your init.el file and running the corresponding call to install the ox-hugo package.

```sh
.emacs.d/bin/doom sync
```

I'll walk you through an example .org file that can be immediately used with the
theme I created (addison) that this blog uses.


## Configuration {#configuration}

```org
#+TITLE: Hugo
#+HUGO_BASE_DIR: ./
#+HUGO_SECTION: ./posts/

#+hugo_weight: auto
#+hugo_auto_set_lastmod: t
#+options: author: nil

* Homepage
* Blog Posts
* About
```

[//]: # "Exported with love from a post written in Org mode"
[//]: # "- https://github.com/kaushalmodi/ox-hugo"
