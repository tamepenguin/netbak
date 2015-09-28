import socket
import sys
from _socket import SO_REUSEADDR
import io

OUTFILE='/tmp/srv1' 
HOST = ''   # Symbolic name meaning all available interfaces
PORT = 8888 # Arbitrary non-privileged port
 
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET,SO_REUSEADDR, 1)
print 'Socket created'
 
try:
    s.bind((HOST, PORT))
except socket.error , msg:
    print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
    sys.exit()
     
print 'Socket bind complete'
 
s.listen(10)
print 'Socket now listening'
 
#wait to accept a connection - blocking call
conn, addr = s.accept()
s.settimeout(0.0)
print 'Connected with ' + addr[0] + ':' + str(addr[1])
 
try:
    f = open(OUTFILE, 'w')
except:
    print 'Error opening outfile for writing, exit'
    sys.exit(1)
    
print 'Opened oufile for writing'
# metadata!




 

while 1:
    data = conn.recv(1024)
    if not data: break
    f.write(data)
 

conn.close()
s.close()
print 'finished.'


