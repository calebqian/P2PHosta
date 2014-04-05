require './bidirectional_server.rb'
require 'pp'
require 'socket'


class VirtualBrowser < BidirectionalServer

  @server
  @browse_before_time
  @browse_after_time
  def initialize
  end

  def browse_page(pagename)
    @browse_before_time = Time.now 
    @server.puts "BROWSE:#{pagename}"
  end

  def start(hostname, port)
   puts "starting my virtual browser..."
   @server = TCPSocket.open(hostname, port)
   Thread.start{
     while line = @server.gets
       puts line.chop
       if(line.start_with?("GOFOR"))
         puts "This is GOFOR"
         line_array = line.split(":");
         pagename = line_array[1];
         peer = line_array[2];
         peer_port = line_array[3];
         puts "I am trying to get #{pagename} from #{peer} at #{peer_port}"
         peer_server = TCPSocket.open(peer, peer_port.to_i)
         puts "Connected."
         peer_server.puts "BROWSE:#{pagename}"
         puts "I sent BROWSE request"
         file =  peer_server.read
         pp "I got: #{file}"
         @browse_after_time = Time.now
         diff = @browse_after_time - @browse_before_time
         puts "response time: #{diff} seconds"
       end
     end
     @server.close
   }
  end 
end

vb = VirtualBrowser.new
vb.start('center.p2phosta.uiucscheduling.emulab.net', 3000)
vb.browse_page('index.html')
while(1)
end
