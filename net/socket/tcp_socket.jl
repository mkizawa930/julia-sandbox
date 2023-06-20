using Sockets

port = 8080

# bindせずにソケットを用意
socket = TCPSocket(delay=true)

# localhostにbind
bind(socket, Sockets.localhost, port)

