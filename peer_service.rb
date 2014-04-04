require './peer_server.rb'


host = 'localhost'
port = 3000
receiver_port = 3001
client = PeerServer.new(receiver_port)
client.start
client.ping(host, port);

# Peer is encouraged to run forever!
while(1)
end

