require './central_server.rb'

port = 3000
server = CentralServer.new
server.start port
