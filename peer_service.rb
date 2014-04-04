require './peer_server.rb'


host = 'localhost'
port = 3000
receiver_port = 3001
client = PeerServer.new
client.start(receiver_port)
client.send_message('I am Caleb.', host, port);
client.send_message('I am John.', host, port);
client.send_message('This is another test.', host, port);

# Peer is encouraged to run forever!
while(1)
end

client.stop
