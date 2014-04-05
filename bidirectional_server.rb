require 'socket'
require 'pp'

class BidirectionalServer


  def request_type(line)
    ret = -1 # unkown request
    if(line.start_with?('PING'))
      ret = 0
    else
    end
    ret
  end

  def ping(host, port, receiver_port)
    time_before = Time.now
    puts "Pinging #{host} #{port}..."
    server = TCPSocket.open(host, port)
    server.puts "PING:#{receiver_port}"
    while line = server.gets
      puts line.chop
      if(line.start_with?('PONG'))
        time_after = Time.now
        diff = time_after - time_before
        puts "#{diff} seconds elapsed."
        break
      end
    end

  end

  def pong(client)
    puts 'sending PONG...'
    client.puts 'PONG'
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


  protected  :open_connection_thread, :send_message, :accept_handler
  private :pong

end

