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
    puts "Entering accept_handler..."
    while line = client.gets
      puts line.chop
      if(request_type(line)==1)
         puts "dealing with BROWSE"     
         line_array = line.split(":");
         puts "searching for #{line_array[1]}"
         path = "./tests/peer1/#{line_array[1].chop}"
         pp path
         file = File.open(path, "rb");
         pp "File opened correctly."
         contents = file.read;
         contents.length
         file.close;
         client.puts contents.length
         client.write contents
         puts "contents sent."
      end
    end
    super
  end

end
