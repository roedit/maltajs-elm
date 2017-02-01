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

$ AUTH_TOKEN=yoursecrettoken MONGODB_PORT=yourmongoport PORT=optional npm start
```

The app will be running on `localhost` at the port you specified (default is 3000).

Default port for **mongod** is 27017
