require 'socket'
require './bidirectional_server.rb'

class PeerServer < BidirectionalServer
  # since peer performs as a server,
  # it also needs a TCP server socket
  @receiver_port
  def initialize(receiver_port)
    @receiver_port = receiver_port
  end
 
 
  def command_type
  end

  # override ping
  def ping(host, port)
    super host, port, @receiver_port
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
