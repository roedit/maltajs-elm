[![Build Status](https://travis-ci.org/pietro909/maltajs-elm.svg?branch=master)](https://travis-ci.org/pietro909/maltajs-elm)

# MaltaJS website

## Requirements

 - NodeJs >= 4.3.2
 - Npm >= 3.1.0
 - MongoDB

## Instructions

```
$ npm install

$ make all

$ npm start
```

The app will be running on `localhost` at the port you specified (default is 3000).

## Environment variables

* **MONGODB_URI** is the address to a db instance in the standard MongoDB URI format
* **AUTH_TOKEN** is the token to be used when retrieving the subscriber's list
* **MONGODB_PORT** works only if **MONGODB_URI** is not defined, is the local instance's port (default 27017)
* **PORT** is the port you want the server to bind (default 3000)

