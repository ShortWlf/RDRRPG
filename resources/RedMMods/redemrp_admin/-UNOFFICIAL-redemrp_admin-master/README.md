# -UNOFFICIAL-redemrp_admin
Unofficial admin tool, all credits go for https://github.com/kanersps/ i just imported it to work properly with redm.

##Usage

control for no-clip: WASD , use left SHIFT to go down and space to go UP

key DEL to open it
key DEL to close it

You will need add ace permission to your server cfg:

```
add_ace resource.redem command.sets allow
add_ace resource.redem command.add_principal allow
add_ace resource.redem command.add_ace allow


add_ace group.admin redem_admin allow -- allow admin to use it
add_ace group.superadmin redem_admin allow -- allow superadmins to use it

add_principal identifier.steam:hex_identifier group.superadmin --write steam64id hex of your profile to add you to superadmin group
add_principal identifier.steam:hex_identifier group.superadmin --write steam64id hex of your profile to add you to admin group
```


i like keep the memes alive so:

HINT: rename the folder to redem_admin to make it work
