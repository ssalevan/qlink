var net = require('net');

var HOST = '127.0.0.1';
var PORT = 1337;

var hatchery = Buffer([0x55, 0xFA, 0x00, 0x01, // Header "U" + Small Forced Reply: #message_DESCRIBE to Region Object
                       // (4) Region/System Variables
                       0x5d, 0x55,    // terrain_type
                       0x5d, 0x55,     // light_level
                       0x20,         // region_depth
                       0x5d, 0x55,     // region_class
                       0x01,         // Who_am_I (NOID)
                       0x5d, 0x55, 0x5d, 0x55, 0x5d, 0x55, 0x5d, 0x55, //bank_account_balance
                       // (20) Contents List
                       0x01, 0x01,    // Avatar
                       0x02, 0x24,    // Ground
                       0x03, 0x50,    // Wall
                       0x04, 0x7f,    // Head
                       0x05,   23,    // Door
                       0x06,   56,     // Short Sign
                       0x5d, 0x55,    // EOL
                       // (34) Contents state vars, in list order, starting with the Avatar
                       0x5d, 0x55,    // Style
                       0x54,        // X
                       0x90,        // Y
                       0x02,        // Orientation
                       0x5d, 0x55,    // Ani state
                       0x5d, 0x55,    // Contained by (NOID)
                       0x92,        // Avatar: Activity
                       0x92,        // Avatar: Action
                       0x5d, 0x55,    // Avatar: Health
                       0x5d, 0x55,     // Avatar: Restrainer
                       0x02, 0x34,     // Avatar: Customize
                       // (51) Ground:               
                       0x01, 0x5d, 0x55, 0x04, 0xe4, 0x5d, 0x55, 0x5d, 0x55,
                       // (60) Wall:
                       0x04, 0x5d, 0x55, 0x5d, 0x55, 0xc4, 0x5d, 0x55, 0x5d, 0x55,
                       // (70) Head
                       0x01, 0xc8, 0x24, 0x10, 0x01, 0x5d, 0x55,
                       // (77) Door
                       0x5d, 0x55, 0x80, 0x21, 0x88, 0x5d, 0x55, 0x5d, 0x55,
                       0x5d, 0x55, 0x5d, 0x55, 0x5d, 0x55, // Door State and Key 0,0,0
                       // (91) Short Sign
                       0x04, 0x18, 0x88, 0x8c, 0x5d, 0x55, 0x5d, 0x55,
                       32, 84, 104, 101, 32, 77, 65, 68, 69, 32,   // " The MADE "
                       0x5d, 0x55,    // EOL
                       0 ]);           // EOP (113)

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
