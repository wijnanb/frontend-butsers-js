config = require('./config.js').config
express = require 'express'
fs = require 'fs'
path = require 'path'
eco = require 'eco'

nextId = 3
list = {
    "1": {
        "id": "1",
        "msg": "msg1"
    },
    "2": {
        "id": "2",
        "msg": "msg2"
    }
}
server = express()

server.configure ->
    server.use '/static', express.static path.join(__dirname, '/static')
    server.use express.bodyParser()
    server.use (req, res, next) ->
        if req.type is 'OPTIONS' then res.send 200
        res.header 'Access-Control-Allow-Origin', config.allowedDomains
        res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
        res.header 'Access-Control-Allow-Headers', 'Content-Type,X-Requested-With'
        next()

server.get '/list', (req, res) ->
    res.send list

server.get '/list/:id', (req, res) ->
    id = req.params.id
    res.send list[id]

server.post '/list', (req, res) ->
    id = nextId++
    req.body['id'] = id
    list[id] = req.body
    res.send req.body

server.put '/list/:id', (req, res) ->
    id = req.params.id
    list[id] = req.body
    res.send req.body


console.log "http server running on port " + config.server_port
server.listen config.server_port