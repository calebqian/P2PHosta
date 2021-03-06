require './bidirectional_server.rb'
require 'pp'
require 'socket'

Thread.abort_on_exception = true

class VirtualBrowser < BidirectionalServer
  @counter
  @counter_max
  @server
  @lambda
  @browse_before_time
  @browse_after_time
  def initialize
    @counter = 0
    @counter_max = 10
    super
  end

  def browse_page(pagename)
      puts "Server, I want to browse #{pagename}"
      @browse_before_time = Time.now 
      @server.puts "BROWSE:#{pagename}\n"
  end

  def broadcast(hostname, port, pagename, lam, counter_max)
   server = TCPsocket.open(hostname, port)
   server.puts "BROADCAST:#{pagename}:#{lam}:#{counter_max}" 
  end

  def accept_handler(client)
    while line = client.gets
       if(line.start_with?("BROADCAST"))
         line_array = line.split(":")
         pagename = line_array[1]
         lam = line_array[2].to_i
         @counter = 0
         @lambda = lam
         @counter_max = line_array[3].to_i
         browse_page(pagename)
      end
    end
    super
  end

  def start_vs(hostname, port)
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
         peer_server.print "BROWSE:#{pagename}\n"
         puts "I sent BROWSE request"
         len = peer_server.gets
         file =  peer_server.read len.to_i
         @browse_after_time = Time.now
         diff = @browse_after_time - @browse_before_time
         puts "total RTT: #{diff} seconds"
         @counter += 1
         if(@counter < @counter_max)
           browse_page(pagename)
         end
       end
     end
   }
  end 
end

vb = VirtualBrowser.new
vb.start_vs('center.p2phosta.uiucscheduling.emulab.net', 3000)
vb.start 3001
while(1)
end
