require 'socket'
require './bidirectional_server.rb'

class PeerServer < BidirectionalServer
  # since peer performs as a server,
  # it also needs a TCP server socket
  @receiver_port
  def initialize(receiver_port)
    @receiver_port = receiver_port
  end
 
  def ping(host, port)
    send_message("PING:#{@receiver_port}", host, port)
  end 
 
  def command_type
  end

  def handle_command

  end
  
  # override start, receiver_port already known
  def start
    super @receiver_port
  end  

  def accept_handler(client)
    while line = client.gets
      puts line.chop
    end
    super
  end

end
