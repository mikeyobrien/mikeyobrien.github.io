+++
title = "Using ox-hugo to manage content"
date = 2020-04-19
lastmod = 2021-02-25T20:57:32-06:00
draft = false
weight = 2001
+++

As I've made my way deeper into the emacs rabbit hole I stumbled upon a package
called [ox-hugo](https://ox-hugo.scripter.co) that allows you to use .org files to manage content that can then
be deployed with the static site generator, [hugo](https://gohugo.io/). I've toyed with the idea of
moving it over the past few months, only now getting the configuration in place
to make it a reality as im now managing all content ox-hugo. In the brief time
I've used it I'm confident in recommending it if you already are familiar with
org-mode and emacs.

Fortunately the package is included as an option with [doom-emacs](https://github.com/hlissner/doom-emacs) and is simple as adding,

```lisp
(org
 +hugo)
```

to your init.el file and running the corresponding call to install the ox-hugo package.

```sh
.emacs.d/bin/doom sync
```

Here is an example .org file that can be immediately used with a simple theme I
put together to get a better understanding of hugo (<https://github.com/mikeyobrien/hugo-theme-addison>)

```org
#+TITLE: Hugo
#+HUGO_BASE_DIR: ./
#+HUGO_SECTION: ./posts/

#+hugo_weight: auto
#+hugo_auto_set_lastmod: t
#+options: author:nil

* Homepage
:PROPERTIES:
:EXPORT_HUGO_SECTION:
:EXPORT_FILE_NAME: _index
:END:
This is the home of my blog!
* Blog Posts
:PROPERTIES:
:EXPORT_DATE: 2019-12-16
:EXPORT_FILE_NAME: _index
:END:
** Today Was A Good Day
:PROPERTIES:
:EXPORT_DATE: 2018-06-12
:EXPORT_FILE_NAME: today_was_a_good_day
:END:
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget facilisis mi,
  ut efficitur libero. In hac habitasse platea dictumst. Pellentesque habitant
  morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec at
  iaculis sem, convallis elementum ipsum. Donec aliquam ex quis orci ullamcorper
  ultricies. In at efficitur libero. Fusce vitae lorem ac neque bibendum vehicula.
  Proin viverra gravida libero sit amet dapibus. Nulla tempor neque quis nibh
  euismod commodo nec non augue. Suspendisse sed accumsan risus. Curabitur
  imperdiet ex quis eros scelerisque, non blandit augue condimentum.
** TODO Tomorrow's Thoughts
  Nullam eu ante vel est convallis dignissim. Fusce suscipit, wisi nec facilisis
  facilisis, est dui fermentum leo, quis tempor ligula erat quis odio. Nunc
  porta vulputate tellus. Nunc rutrum turpis sed pede. Sed bibendum. Aliquam
  posuere. Nunc aliquet, augue nec adipiscing interdum, lacus tellus malesuada
  massa, quis varius mi purus non odio. Pellentesque condimentum, magna ut
  suscipit hendrerit, ipsum augue ornare nulla, non luctus diam neque sit amet
  urna. Curabitur vulputate vestibulum lorem. Fusce sagittis, libero non
  molestie mollis, magna orci ultrices dolor, at vulputate neque nulla lacinia
  eros. Sed id ligula quis est convallis tempor. Curabitur lacinia pulvinar
  nibh. Nam a sapien.
* About
:PROPERTIES:
:EXPORT_FILE_NAME: _index
:EXPORT_HUGO_SECTION: about
:END:
Tell the internet about yourself here.
```

Place this .org file at the root of your hugo website directory.
Source for this blog can be found at
<https://github.com/mikeyobrien/mikeyobrien.github.io>.[^fn:1]

[^fn:1]: Updated to new repo location
