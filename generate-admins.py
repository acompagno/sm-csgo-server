import os

admins = os.environ['CSGO_SERVER_ADMINS'] if 'CSGO_SERVER_ADMINS' in os.environ else ''

for admin_id in admins.strip().split(';'):
    print('"{0}" "99:z"'.format(admin_id.strip()))