#!/bin/sh

# sync files (maps, addons, etc) from shared volume
# this really only allows us to sync on server startup, in the future I should probably add a way to syn in real-time
echo "## Copying contents of shared volume ##"
rsync -r $CSGO_SHARED_VOLUME/csgo/* $CSGO_DIR/ -v

# make sure all the generated stuff below appends to the files so we dont overwite things synced from the shared volume
# generate server.cfg file
echo "## Building server.cfg ##"
python $SCRIPTS_DIR/generate-cfg.py | tee -a $CSGO_DIR/cfg/server.cfg
# generate admins file
echo "## Building admins_simple.ini ##"
python $SCRIPTS_DIR/generate-admins.py | tee -a $CSGO_DIR/addons/sourcemod/configs/admins_simple.ini

# call entrypoint of original image
sh $SERVER/csgo.sh $@