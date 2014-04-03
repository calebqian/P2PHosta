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

  def send_message(msg)
    puts 'sending ...'
    @sender.puts msg
  end

  def send_request
  end


  def start(sender_hostname, sender_port)
    puts 'starting...'
    @sender = TCPSocket.new(sender_hostname, sender_port)
    Thread.start {
      while line = @sender.gets
        puts line.chop
      end
    }
    
  end

  def stop
    @sender.close
  end

end
