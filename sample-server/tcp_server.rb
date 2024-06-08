require 'socket'

server = TCPServer.new('localhost', 3002)

request_count = 0

loop do
  client = server.accept

  while (response = client.gets) # read data sent by client
    print response
  end
  client.close
end
