host=`hostname|gawk -F- '{ print $1 $6 }'`
curl --user sub77:sx1r0x "https://myonlineportal.net/updateddns?hostname=$host.myonlineportal.net"

# DNF
echo "DNF"
dnf update -y || true
dnf install -y \
nano
git

