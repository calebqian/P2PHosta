require './peer_server.rb'

Thread.abort_on_exception = true
host = 'center.p2phosta.uiucscheduling.emulab.net'
port = 3000
receiver_port = 3001
client = PeerServer.new(receiver_port)
client.start
client.ping(host, port);

# Peer is encouraged to run forever!
while(1)
end

