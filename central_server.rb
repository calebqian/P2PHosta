require 'socket'
require './bidirectional_server.rb'
require 'pp'
require 'thread'

class CentralServer < BidirectionalServer

  @maxnum_of_replica = 3
  # tenative solution: hash map between peer IP and port number
  @peer_map
  @peer_map_mtx
  @chunk_meta
  @chunk_meta_mtx
  @user_meta
  @user_meta_mtx

  def initialize
    @peer_map = Hash.new{}
    @peer_map_mtx = Mutex.new
    # {chunkname => ["peer1ip", "peer2ip"]}
    @chunk_meta = Hash.new{}
    @chunk_meta_mtx = Mutex.new
    # user meta: {username => {filename => [chunk1, chunk2]}}
    @user_meta = Hash.new{}
    @user_meta_mtx = Mutex.new
    super
  end

  #register peer server
  def register_peer(ip, port)
    puts "registering the instance #{ip}"
    # duplicate insertion will overwrite the previous one
    @peer_map[ip] = port
    # comment this line later
    pp @peer_map.inspect
  end

  def assign_hosting_peers
    h = Hash.new
    num_of_peers = @maxnum_of_replica
    if(@peer_map.size < @maxnum_of_replica)
      num_of_peers = @peer_map.size
    end
    # random assignment
    while i < num_of_peers do
      keys = @peer_map.keys
      ip = keys[rand(keys.length)]
      h[ip] = @peer_map[ip]
      i+=1
    end
    h 
  end

  def register_backup
    # probably a trivia one because
    # backup server is nothing more than a peer
  end


  def update_page(userid, pagename)
    @user_meta_mtx.synchronize do
      list = @user_meta[userid]
      if list.nil?
        list = Hash.new
      end
      list[pagename] = assign_hosting_peers
      pp list[pagename].inspect
    end
  end

  def browse_page(pagename)
   pp "someone wants to browse #{pagename}"
   num_of_peers = @peer_map.size
   if num_of_peers == 0
     return "NOPEER"
   end
   selected = rand(num_of_peers)
   ip = @peer_map.keys[selected] 
  end

  

  # override the accept_handler here
  def accept_handler(client)
    while line = client.gets
      puts line.chop
      if(request_type(line.chop) == 0)
        line_array = line.split(":")
        register_peer(client.peeraddr[3], line_array[1].to_i)
        pong(client)
      elsif(request_type(line.chop) == 1)
       line_array = line.split(":")
       peer = browse_page(line_array[1].chop)
       puts "I found the peer who has it is #{peer} with port #{@peer_map[peer]}" 
       client.puts "GOFOR:#{line_array[1].chop}:#{peer}:#{@peer_map[peer]}"
      end 
    end
    super
  end


  private :request_type, :register_peer, :register_backup, :update_page, :browse_page

end

