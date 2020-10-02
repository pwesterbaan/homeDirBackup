cat >> /root/wol_fix.sh <<EOF
#!/bin/bash
## suggested script if WOL does not persist across boots
ethtool -s enp2s0 wol g
EOF
