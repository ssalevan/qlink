# Q-Link Reloaded

## Deployment instructions

These have only really been tested on Ubuntu 14.04, but they should generalize readily to other environments.

### Step 1: Install prerequisites

On Ubuntu, you can do this with the command

```
apt-get install openjdk-7-jdk maven mysql-server nodejs
```

Elsewhere, you will need:

 * A Java development kit
 * Maven installed
 * MySQL installed and running with default configuration
 * node.js installed

### Step 2: Configure database

There are two SQL files that will set up the "qlink" database the server needs. The "bootstrap" script will run them both. **WARNING!** Running this script will *delete any previous database* and as such will invalidate any QLink disks you were using to connect to it.

### Step 3: Build

There's a "package" script that does this, or you can just type

```
mvn package
```

### Step 4: Run

There's a "run" script, or you can also fire up the executable jar file produced in the "target" directory.

If you want to play with the "wafer-thin" Habitat proxy, you will need to first run

```
nodejs src/fake_server/wafer.js
```

### Step 5: Connect with QLink!

You're now running Q-Link Reloaded listening on port 5190. You should be able to point your Commodore 64 client at that port and then do your normal Q-Link connection techniques.
