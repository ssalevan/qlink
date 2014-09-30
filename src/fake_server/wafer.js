var net = require('net');

var HOST = '127.0.0.1';
var PORT = 1337;

var hatchery = Buffer([0x55, 0xfa, 0x0, 0x01, 0x5d, 0x55, 0x5d, 0x55, 0x20,
                       0x5d, 0x55, 0x1, 0x5d, 0x55, 0x5d, 0x55, 0x5d, 0x55, 0x5d, 0x55,
                       0x1, 0x1,
                       0x2, 0x24,
                       0x3, 0x50,
                       0x4, 0x7f, // heads..
                       0x5, 0x7f,
                       0x6, 0x7f,
                       0x7, 0x7f,
                       0x5d, 0x55, 0x5d, 0x55, 0x54, 0x90, 0x2, 0x5d, 0x55, 0x5d, 0x55, 0x92, 0x92, 0x5d, 0x55, 0x5d, 0x55, 0x2, 0x34, 0x1, 0x5d, 0x55, 0x4, 0xe4, 0x5d, 0x55, 0x5d, 0x55, 0x4, 0x5d, 0x55, 0x5d, 0x55, 0xc4, 0x5d, 0x55, 0x5d, 0x55,
                       0x1, 0xc8, 0x24, 0x10, 0x1, 0x5d, 0x55, // heads..
                       0x2, 0xc8, 0x26, 0x10, 0x1, 0x5d, 0x55,
                       0x3, 0xc8, 0x26, 0x10, 0x1, 0x5d, 0x55,
                       0x4, 0xc8, 0xc6, 0x10, 0x1, 0x5d, 0x55,
                       0x5d, 0x55, 0x00]);

// Create a server instance, and chain the listen function to it
// The function passed to net.createServer() becomes the event handler for the 'connection' event
// The sock object the callback function receives UNIQUE for each connection
net.createServer(function(sock) {
    var cachedRemoteAddress, cachedRemotePort;
    sock.setEncoding('binary');
    cachedRemoteAddress = sock.remoteAddress;
    cachedRemotePort = sock.remotePort;

    // We have a connection - a socket object is assigned to the connection automatically
    console.log('CONNECTED: ' + sock.remoteAddress +':'+ sock.remotePort);

    // Add a 'data' event handler to this instance of socket
    sock.on('data', function(data) {
        str = data.toString();
        delimiter = str.indexOf(":");

        if (delimiter > 0) {
            user = str.substring(0, delimiter);
            console.log('DATA ' + sock.remoteAddress + ': Sending Hatchery to ' + user);
            sock.write(user + ":");
            sock.write(hatchery);
            sock.write("\r");
        } else {
            console.log('Got a message from QLink, but could not deduce a username!');
        }
    });

    // Add a 'close' event handler to this instance of socket
    sock.on('close', function(data) {
        console.log('CLOSED: ' + cachedRemoteAddress +':'+ cachedRemotePort);
    });

}).listen(PORT, HOST);

console.log('Server listening on ' + HOST +':'+ PORT);
