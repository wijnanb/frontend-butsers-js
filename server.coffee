config = require('./config.js').config
express = require 'express'
fs = require 'fs'
path = require 'path'
eco = require 'eco'

nextId = 3
list = {
    "1": {
        "test": "1"
    },
    "2": {
        "test": "2"
    }
}
server = express()

server.configure ->
    server.use '/static', express.static path.join(__dirname, '/static')
    server.use express.bodyParser()
    server.use (req, res, next) ->
        res.header 'Access-Control-Allow-Origin', config.allowedDomains
        res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
        res.header 'Access-Control-Allow-Headers', 'Content-Type'
        next()

server.get '/list', (req, res) ->
    res.send list

server.get '/list/:id', (req, res) ->
    id = req.params.id
    res.send list[id]

server.post '/list', (req, res) ->
    id = nextId++
    list[id] = req.body
    res.send req.body

server.put '/list/:id', (req, res) ->
    id = req.params.id
    list[id] = req.body
    res.send req.body


console.log "http server running on port " + config.server_port
server.listen config.server_port