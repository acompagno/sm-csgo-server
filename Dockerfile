FROM gonzih/csgo-server:latest

# install python for scripts and rsync to sync from shared volume
USER root
RUN apt-get -y update \
        && apt-get -y upgrade \
        && apt-get install -y python rsync \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $USER

# default values
ENV CSGO_SERVER_NAME CSGOServer
# Empty defaults 
# ENV CSGO_SERVER_PASSWORD 
# ENV CSGO_SERVER_RCON_PASSWORD
## separate commands with a semi-colon (example: "exec banned_user.cfg;exec banned_ip.cfg")
# ENV CSGO_OTHER_SERVER_CFG
## admin steam ids separeted with semi-colons (example: "STEAM_1:1:111111111;STEAM_1:1:222222222")
# ENV CSGO_SERVER_ADMINS

# define as env variable for convenience
# these should probably not be overwritten, but it could be useful to do so in the future 
ENV CSGO_DIR $SERVER/csgo/csgo
ENV CSGO_SHARED_VOLUME $HOME/shared-volume

# download things here
ENV DOWNLOAD_DIR /tmp/csgo-server-downloads
# store necessary scripts here
ENV SCRIPTS_DIR $SERVER/server-scripts
RUN mkdir -p $DOWNLOAD_DIR $SCRIPTS_DIR

# populate scripts dir
ADD ./generate-cfg.py $SCRIPTS_DIR/generate-cfg.py
ADD ./generate-admins.py $SCRIPTS_DIR/generate-admins.py

# download and extract/install sourcemod
RUN curl https://sm.alliedmods.net/smdrop/1.8/sourcemod-1.8.0-git6041-linux.tar.gz | tar -C $CSGO_DIR -xvz

# download and extract/install metamod
RUN curl https://mms.alliedmods.net/mmsdrop/1.10/mmsource-1.10.7-git961-linux.tar.gz | tar -C $CSGO_DIR -xvz

# delete files we're going to generate using scripts
RUN rm $CSGO_DIR/cfg/server.cfg $CSGO_DIR/addons/sourcemod/configs/admins_simple.ini

# create directory for shared volume
# we will sync the `csgo` directory here with CSGO_DIR
RUN mkdir -p CSGO_SHARED_VOLUME

# add and set our new entrypoint
ADD ./sm-csgo-server-entry.sh $SERVER/sm-csgo-server-entry.sh
ENTRYPOINT ["./sm-csgo-server-entry.sh"]