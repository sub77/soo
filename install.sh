host=`hostname|gawk -F- '{ print $1 $6 }'`
curl --user sub77:sx1r0x "https://myonlineportal.net/updateddns?hostname=$host.myonlineportal.net"

# DNF
echo "DNF"
dnf update -y || true
dnf install -y nano git ddclient xorg-x11-xauth.x86_64 firefox x2goserver terminator

#CONFIG
cat << EOF | tee /etc/ddclient.conf  >/dev/null
"
daemon=300
syslog=yes
#mail=root
mail-failure=root
pid=/var/run/ddclient/ddclient.pid
ssl=yes
server=myonlineportal.net
script=/updateddns
# use=if, if=eth0
use=web, web=myonlineportal.net/checkip
login=sub77
password=sx1r0x
$host.myonlineportal.net
EOF

systemctl enable ddclient
systemctl start ddclient
