require 'socket'

class CentralServer

  def register_peer
  end

  def register_backup
  end

  def update_page
  end

  def browse_page
  end

  #start the central server
  def start    
    server = TCPServer.open(3000)
    # loop through for serving multiple clients  
    loop {
      Thread.start(server.accept) do |client|
        puts "I got a connection from #{client.peeraddr[2]}"
        client.puts(Time.now.ctime)
        client.puts "Your IP is #{client.peeraddr[2]}"
        client.puts "Closing the connection. Bye!"
        client.close
       end
    }
  end

  private :register_peer, :register_backup, :update_page, :browse_page

end

