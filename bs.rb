#/usr/bin/env ruby -w

require 'socket'




port = "19165"
hostname = '127.0.0.1'
file = "/tmp/f"


outfile = open(file, "w")

socket = TCPServer.open(port)
puts "Server started"
data = ""
  

client = socket.accept
puts "The connection is now in place"
data  = client.read
outfile.write(data)
client.close


socket.close
outfile.close
puts "Server ended"