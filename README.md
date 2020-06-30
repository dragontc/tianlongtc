# ubuntu 16.04 一键搭建vps脚本（支持ipv6）

#在xshell输入

git clone https://github.com/dragontc/tianlongtc 

#将passwd改为自己要设置的密码

tianlongtc/run.sh passwd



# 开启bbr加速（非必须）

wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.10.2/linux-image-4.10.2-041002-generic_4.10.2-041002.201703120131_amd64.deb

dpkg -i linux-image-4.10.2-041002-generic_4.10.2-041002.201703120131_amd64.deb

update-grub

reboot

#等待重启

echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf

echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

sysctl -p

sysctl net.ipv4.tcp_available_congestion_control

ss搭建完成

# 搭建v2ray
https://www.mastercaihao.com/804.html
