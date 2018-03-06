# CSGO SourceMod / Metamod Docker Container

Base container to create specialized CSGO servers using SourceMod / Metamod addons

## Customizing server

### Evironment Variables

This image provides the following environment variables to customize certain aspects of the server:

* CSGO_SERVER_NAME
 * (Default = CSGOServer) Allows you to set the servers `hostname` 
* CSGO_SERVER_PASSWORD
 * (Default: empty string) Allows you to make your server private using the given password
* CSGO_SERVER_RCON_PASSWORD
 * (Default: empty string) Allows you to set the rcon password for the server
* CSGO_OTHER_SERVER_CFG
 * (Default: empty string) Allows you to set arbitrary server commands in your `server.cfg`. Commands should be separated with a `;`.  Example `exec banned_user.cfg;exec banned_ip.cfg`
* CSGO_SERVER_ADMINS
 * (Default: empty string) Allows you to set admins for the server using their [Steam IDs](https://steamidfinder.com/). Example `STEAM_1:1:111111111;STEAM_1:1:222222222` 

### Customize this image
On startup, the server will sync the contents of `$CSGO_SHARED_VOLUME/csgo` into the servers `csgo` directory. This allows you to mount a volume on the host and adding all maps, addons, and  

```
docker run -v '/path/in/host:/home/csgo/shared-volume'
```

### Creating new image

You can use this image as the base of a new Docker image and install any desired plugin, maps, etc.

```
from acompagno/sm-csgo-server
```
