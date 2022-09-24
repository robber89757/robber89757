# 1、备份并删除旧文件
mv kiauh kiauh.old
mv $HOME/klipper_config/webcam.txt $HOME/klipper_config/webcam.txt.old
cp $HOME/.gitconfig $HOME/.gitconfig.old

sudo apt install git pkg-config

# 2、设置加速镜像
#cat << _EOF_ > $HOME/.gitconfig
#[url "https://hub.xn--gzu630h.xn--kpry57d/"]
#        insteadOf = https://github.com/
#_EOF_

#cat << _EOF_ > $HOME/.gitconfig
#[url "https://hub.0z.gs/"]
#        insteadOf = https://github.com/
#_EOF_



sudo rm /etc/pip.conf
mkdir -p $HOME/.config/pip
cat << _EOF_ > $HOME/.config/pip/pip.conf
[global]
index-url=https://pypi.tuna.tsinghua.edu.cn/simple
# extra-index-url=https://www.piwheels.org/simple
timeout = 600
_EOF_

# 3、使用 kiauh 卸载安装 MJPG-Streamer
git clone https://github.com/th33xitus/kiauh

#sed -i.bak "0,/FLUIDD_DL_URL/{s_head -1)_head -1 | sed 's|github.com|ghproxy.com/https://github.com|g')_}" ~/kiauh/scripts/install_klipper_webui.sh
#sed -i.bak "0,/MAINSAIL_DL_URL/{s_head -1)_head -1 | sed 's|github.com|ghproxy.com/https://github.com|g')_}" ~/kiauh/scripts/install_klipper_webui.sh
sed -i.bak 's|raw.githubusercontent.com|ghproxy.com/https://raw.githubusercontent.com|g' ~/kiauh/scripts/fluidd.sh
sed -i 's|github.com|hub.0z.gs|g' ~/kiauh/scripts/fluidd.sh
#sed -i 's|raw.githubusercontent.com|ghproxy.com/https://raw.githubusercontent.com|g' ~/kiauh/scripts/mjpg-streamer.sh
sed -i 's|https://raw.githubusercontent.com|https://raw.0z.gs|g' ~/kiauh/scripts/mjpg-streamer.sh


sleep 1

~/kiauh/kiauh.sh

# 4、修改 webcam.txt 配置文件并重启服务
sed -i '$ a camera_usb_options="-r 640x480 -f 10 -y -d /dev/v4l/by-id/usb-Etron_Technology__Inc._USB2.0_Camera-video-index0"' ~/klipper_config/webcam.txt
sudo systemctl restart webcamd
echo done!
