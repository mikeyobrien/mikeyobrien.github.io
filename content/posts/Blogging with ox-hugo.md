+++
title = "Blogging with org-mode and ox-hugo"
author = ["Mikey O'Brien"]
tags = ["blog"]
categories = ["category1"]
draft = false
+++

Walking through steps I took to setup a blog using org-mode for content creation, on MacOS w/ doom emacs.
To deploy the blog I am using free github pages.


## Setting up Hugo {#setting-up-hugo}


### 1. Install go and hugo. {#1-dot-install-go-and-hugo-dot}

```nil
brew install hugo
```

Follow instructions at: <https://go.dev/doc/install>

As a user of nix, I simply start a dev shell using a flake.


### 2. Add hugo support to your config.el {#2-dot-add-hugo-support-to-your-config-dot-el}

```nil
(org +hugo)
```

Sync and reload emacs `doom sync`, within emacs type sequence `SPC q R`


### 3. Create a new hugo directory, add a theme, install mods {#3-dot-create-a-new-hugo-directory-add-a-theme-install-mods}


#### a. Create directory and enable mods {#a-dot-create-directory-and-enable-mods}

```nil
mkdir blog
cd blog
hugo site new .
hugo mod init github.com/<username>/<repo>
mkdir content-org
```


#### b. Add theme to config.toml, I'm using PaperMod (insert link) {#b-dot-add-theme-to-config-dot-toml-i-m-using-papermod--insert-link}

```nil
[module]
  [[module.imports]]
    path = "github.com/adityatelange/hugo-PaperMod"
```


#### c. init theme {#c-dot-init-theme}

```nil
hugo mod get -u
```


#### d. start server `hugo server --buildDrafts --navigateToChanged` {#d-dot-start-server-hugo-server-builddrafts-navigatetochanged}


### 4. Start blogging {#4-dot-start-blogging}

Create a new post in `content-org/all-posts.org`, insert the following to demo,

```text
#+hugo_base_dir: ../
* My first post                                             :tag1:@category1:
:PROPERTIES:
:EXPORT_FILE_NAME: my-first-post
:END:
This is my post body
```

   Export the post `C-c C-e H H`
\*\*


## Deploying {#deploying}

To deploy I'm leveraging free Github pages. This method will deploy my blog whenever I push to github. Repo must be at `github.com/<username>/<username>.github.io`
This assumes you are familiar with setting DNS records with your DNS provider. I am using AWS Route53.


### 1. Add the github action to `./github/workflows/gh-pages.yml` {#1-dot-add-the-github-action-to-dot-github-workflows-gh-pages-dot-yml}

```nil
name: github pages

on:
  push:
    branches:
      - main  # Set a branch that will trigger a deployment
  pull_request:

jobs:
  deploy:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v3
        with:
          submodules: true  # Fetch Hugo themes (true OR recursive)
          fetch-depth: 0    # Fetch all history for .GitInfo and .Lastmod

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          # extended: true

      - name: Build
        run: hugo --minify

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        if: github.ref == 'refs/heads/main'
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```


### 2. Add verified domain to Github {#2-dot-add-verified-domain-to-github}

Go to user settings &gt; pages &gt; add verified domain.
<https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/verifying-your-custom-domain-for-github-pages>


### 3. Change repository Settings/Pages to the verified `mikeyobrien.com` {#3-dot-change-repository-settings-pages-to-the-verified-mikeyobrien-dot-com}


### 3. Update DNS Records {#3-dot-update-dns-records}

Set zone apex `==mikeyobrien.com==` as A record with github server ips,

```nil
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

Set www subdomain with CNAME record to `mikeyobrien.github.io`


### 5. Update Settings/Pages to deploy off the gh-pages branch {#5-dot-update-settings-pages-to-deploy-off-the-gh-pages-branch}


## Acknowledgements {#acknowledgements}

-   For more detailed installation instructions for ox-hugo see official instructions here: <https://ox-hugo.scripter.co/doc/quick-start/>
