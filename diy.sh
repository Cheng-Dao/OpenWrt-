#!/bin/bash
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3.5 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib linux-libc-dev

# Modify default IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

#sed -i 's/OpenWrt/Silime/g' package/base-files/files/bin/config_generate

echo '修改时区'
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

echo '修改默认主题'
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile

echo '去除默认bootstrap主题'
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

echo '删除旧版argon,链接新版'
rm -rf ./package/lean/luci-theme-argon

echo '下载新版argon主题'
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

echo '删除旧版kodexplorer'
rm -rf ./package/lean/luci-app-kodexplorer

#echo '修改wifi名称'
#sed -i 's/OpenWrt/Silime/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#rm -rf /package/lean/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
echo '下载自定义软件包'
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone https://github.com/silime/luci-app-xunlei.git package/luci-app-xunlei
git clone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git package/mentohust
#git clone https://github.com/Lienol/openwrt-package.git  package/openwrt-package
git clone https://github.com/silime/luci-app-kodexplorer.git package/luci-app-kodexplorer
git clone https://github.com/silime/luci-app-mentohust.git package/luci-app-mentohust
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
./scripts/feeds update -a
./scripts/feeds install -a
