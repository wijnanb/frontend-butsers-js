exports.config =
    server_port: 9000
    sockets_port: 9001
    leaveat: 2
    countdown: 12          # 2 minutes
    resetAllDelay: 6       # 1 minute
    log_level: 1            # 0 - error, 1 - warn, 2 - info, 3 - debug
    transports: ['websocket', 'htmlfile', 'xhr-polling', 'jsonp-polling']   # don't use flashsockets if not on port 80
    allowedDomains: "*"