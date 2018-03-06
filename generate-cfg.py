import os

hostname = os.environ['CSGO_SERVER_NAME'] if 'CSGO_SERVER_NAME' in os.environ else ''
rcon_password = os.environ['CSGO_SERVER_PASSWORD'] if 'CSGO_SERVER_PASSWORD' in os.environ else ''
server_password = os.environ['CSGO_SERVER_RCON_PASSWORD'] if 'CSGO_SERVER_RCON_PASSWORD' in os.environ else ''
cfg_cmds = os.environ['CSGO_OTHER_SERVER_CFG'] if 'CSGO_OTHER_SERVER_CFG' in os.environ else ''

print('hostname "{0}"'.format(hostname))
print('rcon_password "{0}"'.format(rcon_password))
print('sv_password "{0}"'.format(server_password))

for cfg_cmd in cfg_cmds.strip().split(';'):
    print(cfg_cmd.strip())