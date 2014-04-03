require './peer_server.rb'

host = 'localhost'
port = 3000
client = PeerServer.new
client.start(host, port)
client.send_message('I am Caleb.');
client.send_message('I am John.');
client.send_message('This is another test.');

# Peer is encouraged to run forever!
while(1)
end

client.stop
