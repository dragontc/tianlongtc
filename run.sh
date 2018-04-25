#! /bin/bash
# Copyright (c) 2018 tianlongtc

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


wrong_para_prompt() {
    echo "参数输入错误!$1"
}

install() {
	if [[ "$#" -lt 1 ]]
        then
          wrong_para_prompt "请输入至少一个参数作为密码"
	  return 1
	fi
        port="1024"
        if [[ "$#" -ge 2 ]]
        then
          port=$2
        fi
        if [[ $port -le 0 || $port -gt 65535 ]]
        then
          wrong_para_prompt "端口号输入格式错误，请输入1到65535"
          exit 1
        fi
	echo "{
    \"server\":\"0.0.0.0\",
    \"server_port\":$port,
    \"local_address\": \"127.0.0.1\",
    \"local_port\":1024,
    \"password\":\"$1\",
    \"timeout\":300,
    \"method\":\"aes-256-cfb\"
}" > /etc/shadowsocks.json
	apt-get update
	apt-get install -y python-pip
	pip install --upgrade pip
	pip2 install setuptools
	pip2 install shadowsocks
	chmod 755 /etc/shadowsocks.json
	apt-get install python-m2crypto
        command -v ssserver >/dev/null 2>&1 || { echo >&2 "请确保你服务器的系统是Ubuntu。如果系统是Ubuntu，似乎因为网络原因ss没有安装成功，请再执行一次搭建ss脚本代码。如果试了几次还是不行，执行reboot命令重启下服务器之后再试下"; exit 1; }
	ps -fe|grep ssserver |grep -v grep > /dev/null 2>&1
        if [ $? -ne 0 ]
        then
          ssserver -c /etc/shadowsocks.json -d start
        else
          ssserver -c /etc/shadowsocks.json -d restart
        fi
	rclocal=`cat /etc/rc.local`
        if [[ $rclocal != *'ssserver -c /etc/shadowsocks.json -d start'* ]]
        then
          sed -i '$i\ssserver -c /etc/shadowsocks.json -d start'  /etc/rc.local
        fi
	echo "install success"
	cat /etc/shadowsocks.json
}


if [ "$EUID" -ne 0 ]; then
  echo '必需以root身份运行，请使用sudo命令'
  exit 1;
fi

install $1 $2

