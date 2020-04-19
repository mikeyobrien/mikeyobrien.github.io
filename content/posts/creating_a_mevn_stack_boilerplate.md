+++
title = "Creating a MEVN stack boilerplate"
date = 2018-06-12
lastmod = 2020-04-12T16:08:15-05:00
draft = false
weight = 2007
+++

This post will cover the basic steps needed to set up a project using the MEVN
stack (mongo, express, vue, and nginx). Prior warning, if you are looking for a
tutorial on creating a web application using the MEVN stack you may want to look
elsewhere. I'll only be covering the basic project structure, packages, and
tools necessary to get started.


## Prerequisites {#prerequisites}

-   Basic understanding of javascript
-   Commandline familiarity
-   Familiarity with NPM

To be begin we first need to insure that node is installed on the machine. We
will be using the vue-cli tool to generate the project. To check that it is
installed try running,

```sh
$ node --version
```

If a version number isn't installed we can install nodejs with the following,

```sh
$ curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
$ sudo apt-get install -y nodejs
```

Now that nodejs and npm are installed we can begin the process of setting up our vue and express project folder.

First install vue-cli:

```sh
$ npm install -g vue-cli
```

Now that vue-cli is installed we can use webpack template to generate a vue project

```sh
$ vue init webpack project
```

For this particular project, choose the default settings for everything. Once
finished initializing, move to the newly generated project folder

```sh
$ cd project
```

Now that we're in our root project folder we'll create a server subdirectory
that will contain the backend express code,

```sh
$ mkdir server
```

Once we're all set up the directory structure will look like this,

```nil
project/
├── build
├── config
├── node_modules
├── server
├── src
├── static
├── test
├── README.md
├── index.html
├── package-lock.json
└── package.json
```


## Backend Configuration {#backend-configuration}

We're now ready to setup our express backend and link it to mongodb using the
mongoose library.

```sh
$ cd server
$ npm init
```

Let's being with installing the basic packages that are required for our
application

```sh
$ npm install --save express cors morgan body-parser mongoose
```

-   express is used for handling http requests and responses.
-   cors allows cross-origin resource sharing.
-   morgan is an express middleware for logging.
-   body-parser will parse incoming request bodies before hitting handlers.
-   mongoose will be used to connect to our mongo db.

In the server directory, make a new directory src to hold all our backend source code, and create the app.js file,

```sh
$ mkdir src && touch src/app.js
```

Also, create our models directory to hold our future schemas,

```sh
$ mkdir models
```

Edit the new app.js file to contain all our installed packages,

```javascript
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const morgan = require('morgan')
var mongoose = require('mongoose');

// Express configuration
const app = express()
app.use(morgan('combined'))
app.use(bodyParser.json())
app.use(cors())
app.listen(process.env.PORT || 8081)

// Mongoose configuration
mongoose.connect('mongodb://localhost:27017/project');
var db = mongoose.connection;
db.on("error", console.error.bind(console, "connection error"));
db.once("open", function(callback){
  console.log("Connection Succeeded");
});

// Test handler
app.get('/test', (req, res) => {
  res.send(
    [{
      serviceName: 'test',
      isRunning: true
    }]
  )
})
```

Let's run the application,

```sh
$ node app.js
```

You'll most likely see the connection error printed to the console. If so,
follow the steps to install the community edition for your OS at,
<https://docs.mongodb.com/manual/administration/install-community/>

Now that mongodb is installed let's try that again.

Hopefully we now see "Connection Succeeded".

Running the server app using node app.js isn't very convenient, lets install
nodemon so everytime our server code is updated we reload the backend code,

```sh
$ npm install --save nodemon
```

Edit package.json to contain the following script,

```json
{
  "name": "server",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "start": "./node_modules/nodemon/bin/nodemon.js src/app.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}
```

Lets confirm everything is working as expected. Run the command,

```sh
$ npm run start
```

And direct your browser to <http://localhost:8081>. Update the test function in src/app.js to

```javascript
// Test handler
app.get('/test', (req, res) => {
  res.send(
    [{
      serviceName: 'test',
      isRunning: false
    }]
  )
})
```

Save the file and refresh your browser. You should now see the updated test handler. Our backend is now set up for basic testing.


## Frontend Configuration {#frontend-configuration}

Let's ensure everything is working correctly. Switch back to root of the project,

```sh
$ cd ..
```

Install the base packages we'll need for this project.

```sh
$ npm install axios
```

Well use the axios library to make http requests to our backend service.
run,

```sh
npm run dev
```

Open your browser to: <http://localhost:8081> where you should see something similar to the image below.

{{< figure src="/images/vue.png" >}}

Great! Everything seems to be working. Let's begin by cleaning up some of the boilerplate provided by vue init and creating our src directory from scratch.

```sh
$ sudo rm -rf src\*
```


### main.js {#main-dot-js}

Create the entry-point to our vue application under src.

```sh
touch src\main.js
```

Edit the file to contain,

```jsx
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
```


### Root Vue {#root-vue}

Create the root vue file,

```sh
$ touch src/App.Vue
```

Edit the file to contain,

```jsx
<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>
```


### Vue Router {#vue-router}

Create the router directory,

```sh
$ mkdir src/router
```

Create the index.js file that declares our apps routes,

```nil
$ touch src/router/index.js
```

Edit the file to contain,

```jsx
import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/Home'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    }
  ]
})
```


### Services directory {#services-directory}

Create the services directory to contain the code that connects to our backend api,

```sh
$ mkdir src/services
```

Create a file called Api.js and add the following to the file,

```jsx
import axios from 'axios'

export default() => {
  return axios.create({
    baseURL: `http://localhost:8081`
  })
}
```

In the same file let's add another file TestService.js that will make requests to our backend.

Add to the file,

```jsx
import Api from '@/services/Api'

export default {
  testStatus () {
    return Api().get('test')
  }
}
```


### Home Component {#home-component}

Create the components directory,

```sh
$ mkdir src/components
```

Create the Home component

```sh
touch src/components/Home.vue
```

Add to the Home.vue file,

```jsx
<template>
  <div>
    {{ status }}
  </div>
</template>

<script>
import TestService from '@/services/TestService'

export default {
  name: 'Home',
  data () {
    return {
      status: []
```


### Assets {#assets}

Finally create a directory to hold any future assets.

```sh
$ mkdir src/assets
```

If you stopped the dev server run npm run dev
Check to see if everything was created properly at <http://localhost:8081>

{{< figure src="/images/vue-assets.png" >}}

If it looks similar to the picture above our frontend and backend our now connected!


## Deploying the application {#deploying-the-application}

Now that the frontend and backend are running successfully on the local machine,
it's time to provision the server that we will deploy the boilerplate
application on.

The rest of the post assumes you have a remote server to deploy the application
to using any hosting provider of your choice (aws, google cloud, azure,
digitalocean, etc.)


### MongoDB {#mongodb}

SSH into the remote server and follow the previous instructions used to
provision our local machine.


### nginx {#nginx}

Right now we are running the backend on 8081. A vast majority of the time users
should be able to reach the frontend and backend under a single ip
address/domain. In order to achieve this we have to use a reverse proxy to
redirect incoming requests to www.[your-domain-name].com to our built frontend
code and www.[your-domain-name].com/api to our express app running on port 8081.

Before we begin configuring the nginx to reverse proxy incoming requests we'll
need to move the code on our local machine to the remote server


### Push project to the remote server {#push-project-to-the-remote-server}

On the remote server change your working directory to _var/www_. We'll need to
define where our built project resides which will make more sense later when we
get to setting the nginx configuration.

Using git we can push the code to a remote repository, then clone and build the
application on the host server following the same steps above to provision the
remote server with nodejs and npm.

Another option would be to compress the project folder and copy it over to the
target server, although using this method results in losing the benefit of
source control.

Once the project is under _var/www/<project>_

```sh
$ cd <project>
```

And build the vue app for production.

```sh
$ npm run build
```

When the build completes, you should see a new folder under the root project
directory called dist, this is the folder nginx should serve when a client makes
a request.


### Host Server Configuration {#host-server-configuration}

Now that the necessary files have been pushed and built it is time to configure
nginx to serve our boilerplate application.

Install nginx,

```sh
$ sudo apt-get update && sudo apt-get upgrade sudo apt-get install nginx -y
```

Confirm nginx is installed.

```sh
$ sudo systemctl status nginx
```

Configure nginx to start on system bootup. sudo systemctl enable nginx

Using your preferred text editor, edit the nginx config to serve the application
over port 80. The config file can be found at

```nil
/etc/nginx/sites-available/default
```

Edit the file to match the following,

```nginx
server {
  listen 80 default_server;
  server_name <server_ip/domain name>;

  location / {
    root /var/www/<project>/dist;
    try_files $uri /index.html;
  }

  location /files/ {
    autoindex on;
    root /var/www/<project>dist/static;
  }

  location /api/ {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;
    proxy_pass http://127.0.0.1:8081/;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_redirect off;
    proxy_set_header   X-Forwarded-Proto $scheme;
  }
}
```

Update nginx to read the new config file.

```sh
$ sudo systemctl restart nginx
```

The last thing we need to do is edit the Api.js file to use the correct domain
name/ip address as the baseURL.

```jsx
import axios from 'axios'

export default() => { return axios.create({ baseURL:
  `http://<server_ip/domain>/api` }) } 1234567
```

If all went well, directing your browser to the ip/domain name of the server
should serve up the test home page.

This concludes the basic setup for a MEVN stack project.

[//]: # "Exported with love from a post written in Org mode"
[//]: # "- https://github.com/kaushalmodi/ox-hugo"
