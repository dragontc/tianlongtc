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

#ss搭建完成

# 搭建v2ray

https://www.mastercaihao.com/804.html

#安装curl

apt update

apt install curl

#下载v2ray脚本文件

curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh

curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-dat-release.sh

#安装v2ray

bash install-release.sh

#启动v2ray

systemctl start v2ray

# 为V2ray启用TLS加密(域名指向vps地址)

#安装socat组件，这是下一步acme.sh所需要的一个组件。

apt install socat

#下载并安装acme.sh

curl  https://get.acme.sh | sh

#为域名生成证书

~/.acme.sh/acme.sh --issue -d yourdomain.com --standalone -k ec-256

#将刚申请的ecc证书安装到v2ray目录

~/.acme.sh/acme.sh --installcert -d yourdomain.com --fullchainpath /usr/local/etc/v2ray/v2ray.crt --keypath /usr/local/etc/v2ray/v2ray.key --ecc

# 修改配置文件

...

# 安装trojan

https://www.v2rayssr.com/trojan-2.html
https://trojan-tutor.github.io/2019/04/10/p41.html
