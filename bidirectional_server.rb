require 'socket'

class BidirectionalServer


  def request_type(line)
    ret = -1 # unkown request
    if(line.start_with?('PING'))
      ret = 0
    else
    end
    ret
  end

  def send_message(msg, sender_hostname, sender_port)
    puts "I am sending #{msg} to #{sender_hostname}:#{sender_port}" 
    server = TCPSocket.open(sender_hostname, sender_port)
    server.puts msg
    server.close
  end


  def accept_handler(client) 
    client.close
  end

  def open_connection_thread(server)
    Thread.start(server.accept) do |client|
      accept_handler client
    end
  end

  def start(port)
    Thread.start {
      receiver = TCPServer.open(port)
      loop {
        open_connection_thread(receiver)  
      }
    }
  end


  protected  :open_connection_thread,:send_message, :accept_handler
end

