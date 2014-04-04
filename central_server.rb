require 'socket'
require './bidirectional_server.rb'

class CentralServer < BidirectionalServer

  #register peer server
  def register_peer
  end

  def register_backup
  end

  def update_page
  end

  def browse_page
  end


  
  # TODO: this method checks request message, returns request type
  def request_type(request)
  
  end

  # override the accept_handler here
  def accept_handler(client)
    while line = client.gets
      puts line.chop
      send_message('I got cha!', client.peeraddr[2], 3001)
    end
    super
  end


  private :request_type, :register_peer, :register_backup, :update_page, :browse_page

end

