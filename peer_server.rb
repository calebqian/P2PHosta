require 'socket'
require './bidirectional_server.rb'

class PeerServer < BidirectionalServer
  # since peer performs as a server,
  # it also needs a TCP server socket
  @sender

  def command_type
  end

  def handle_command

  end
  
  def accept_handler(client)
    while line = client.gets
      puts line.chop
    end
    super
  end

end
