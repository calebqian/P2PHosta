require 'socket'

class CentralServer

  #register peer server
  def register_peer
  end

  def register_backup
  end

  def update_page
  end

  def browse_page
  end

  # TODO: this method checks any incoming message and
  # return true or false for its command integrity.
  # TODO: use ruby's openSSL, need certificate on other nodes
  def command_integrity

  end
  
  # TODO: this method checks command message, returns command type
  def command_type(command)
  
  end

  def open_connection_thread(server)
    Thread.start(server.accept) do |client|
      # TODO: check for integrity of command
      # TODO: check command type and route it to respective method 
      puts "I got a connection from #{client.peeraddr[2]}"
      client.puts(Time.now.ctime)
      client.puts "Your IP is #{client.peeraddr[2]}"
      while line = client.gets
        puts line.chop
        client.puts "Talk to me again!"
      end
      client.close
    end
  end

  # start the central server
  def start    
    server = TCPServer.open(3000)
    # loop through for serving multiple clients  
    loop {
      open_connection_thread(server)
    }
  end

  private :command_type, :open_connection_thread, :register_peer, :register_backup, :update_page, :browse_page

end

