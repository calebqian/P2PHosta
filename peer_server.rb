require 'socket'

class PeerServer

  def start(hostname, port)
    server = TCPSocket.open(hostname, port)
    while line = server.gets
      puts line.chop
      server.puts 'hello center!'
    end
    server.close
  end
end
