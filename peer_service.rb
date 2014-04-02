require './peer_server.rb'

host = 'localhost'
port = 3000
client = PeerServer.new
client.start(host, port)
