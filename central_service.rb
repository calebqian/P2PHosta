require './central_server.rb'
Thread.abort_on_exception = true

port = 3000
server = CentralServer.new
server.start port


while(1)
end
