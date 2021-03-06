# !/bin/bash
# Copyright © ~ Yunus Emre Ak

# Terminali temizleme
clear

echo ""
echo '---------------------------------------------------------'
echo 'Format Sonrası Toplu Kurulum | Ubuntu 19.04 Disco'
echo 'Copyright © ~ Yunus Emre Ak'
echo '---------------------------------------------------------'
echo ""

echo "Kurulum başladı... 🌇"

wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &>/dev/null
sudo apt install -yf ./chrome.deb &>/dev/null
rm chrome.deb &>/dev/null
echo "Chrome kurulumu tamamlandı 🎉"

sudo apt install -y chrome-gnome-shell &>/dev/null
sudo apt install -y gir1.2-clutter-1.0 gir1.2-clutter-gst-3.0 gir1.2-gtkclutter-1.0 &>/dev/null
google-chrome https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep?hl=en https://extensions.gnome.org/extension/1160/dash-to-panel/ https://extensions.gnome.org/extension/750/openweather/ https://extensions.gnome.org/extension/1162/emoji-selector/ https://extensions.gnome.org/extension/779/clipboard-indicator/ https://extensions.gnome.org/extension/690/easyscreencast/ &>/dev/null
echo "Eklentiler aktif 🎉"

sudo apt --purge remove -y firefox* &>/dev/null
sudo rm -rf ~/.mozilla /etc/firefox /usr/lib/firefox /usr/lib/firefox-addons &>/dev/null
echo "Firefox kaldırıldı 🎉"

touch ~/Templates/Text.txt
echo '#!/bin/bash' >~/Templates/Script.sh
echo "Artık dizinlere sağ tıklyarak text veya script dosyası oluşturabilirsin 🎉"

sudo apt -y dist-upgrade &>/dev/null
sudo apt -y update &>/dev/null
sudo apt -y upgrade &>/dev/null
sudo apt -y autoremove &>/dev/null
echo "Paketler yenilendi 🎉"

# Font terminalden yüklenmezse her uygulama görmüyor
sudo apt install -y unrar gnome-tweaks flameshot fonts-noto-color-emoji ntfs-3g libcanberra-gtk-module &>/dev/null
echo "Artık emoji kullanabilir, özelleştirme yapabilir ve rar dosyalarını ayrıştırabilirsin 🎉"

mkdir -p $HOME/Pictures/Icons/Svg &>/dev/null
wget -O $HOME/Pictures/Icons/Svg/whatsapp_webapp.svg https://drive.google.com/uc?id=1V5nqM6ocfWVcL682JtvT7urMBkVtGl2k &>/dev/null
sudo bash -c 'echo "#usr/bin/env xdg-open
[Desktop Entry]
Name=WhatsApp
GenericName=WhatsApp
Comment=WhatsApp desktop webapp
Exec=/opt/google/chrome/google-chrome --app=https://web.whatsapp.com/
Terminal=false
Type=Application
StartupNotify=true
MimeType=text/plain;
Icon=$(echo $HOME/Pictures/Icons/Svg/whatsapp_webapp.svg)
Categories=Network;Application;
Keywords=WhatsApp;webapp;
X-Ubuntu-Gettext-Domain=WhatsApp
StartupWMClass=web.whatsapp.com" > /usr/share/applications/whatsapp-webapp.desktop'
echo "Whatsapp kısayolu oluşturuldu 🎉"

mkdir -p $HOME/Pictures/Icons/Svg &>/dev/null
wget -O $HOME/Pictures/Icons/Png/google_translate.png https://upload.wikimedia.org/wikipedia/commons/d/db/Google_Translate_Icon.png &>/dev/null
sudo bash -c 'echo "#usr/bin/env xdg-open
[Desktop Entry]
Name=GoogleTranslate
GenericName=GoogleTranslate
Comment=GoogleTranslate desktop webapp
Exec=/opt/google/chrome/google-chrome --app=https://translate.google.com/#view=home&op=translate&sl=auto&tl=tr
Terminal=false
Type=Application
StartupNotify=true2
MimeType=text/plain;
Icon=$(echo $HOME/Pictures/Icons/Png/google_translate.png)
Categories=Network;Application;
Keywords=GoogleTranslate;webapp;
X-Ubuntu-Gettext-Domain=GoogleTranslate
StartupWMClass=translate.google.com" > /usr/share/applications/chrome-webapp.desktop'
echo "GoogleÇeviri kısayolu oluşturuldu 🎉"

sudo apt install -y kolourpaint &>/dev/null
echo "Kolourpaint kurulumu tamamlandı 🎉"

sudo apt install -y cheese &>/dev/null
echo "Cheese kurulumu tamamlandı 🎉"

sudo apt install -y totem &>/dev/null # Video codec ubuntu-restricted-extras
echo "Totem kurulumu tamamlandı 🎉"

# Git kurulumu
# Git ve Git-lfs Kurulumu
wget -O "$HOME/Downloads/script.deb.sh" "https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh"
sudo bash "$HOME/Downloads/script.deb.sh"
sudo apt install -y git git-lfs
git lfs install
rm "$HOME/Downloads/script.deb.sh" &>/dev/null

read -p "Git e-postanızı girin (örn: yemreak@gmail.com) " # -n 1 -r
git config --global user.email "$REPLY"
read -p "Git için isminizi girin (örn: Yunus Emre) " # -n 1 -r
git config --global user.name "$REPLY"
echo "Git ve Git-Lfs kurulumu tamamlandı 🎉"

git config --global credential.helper store
echo "Artık git bilgileri kayıt ediliyor 🗃"

wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868 &>/dev/null
sudo apt install -yf ./code.deb
rm code.deb &>/dev/null
echo "VsCode kuruldu, artık kodlayabilirsin 🎉"

wget -O firacode2.zip "https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip" &>/dev/null
unzip firacode2.zip -d "./Fira Code 2" &>/dev/null
rm firacode2.zip &>/dev/null
mv Fira\ Code\ 2/ $HOME/.fonts &>/dev/null
fc-cache &>/dev/null
echo "Fira Code 2 fontu kuruldu, 'font.ligeratures' ayarını aktif etmeyi unutma 🎉"

# OnlyOfficeDesktop paketinin indirilmesi
wget -O "$HOME/Downloads/onlyofficedesktop.deb" https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb &>/dev/null

# Paketin yüklenmesi (-f: --fix-broken)
sudo apt install -yf "$HOME/Downloads/onlyofficedesktop.deb" &>/dev/null
rm "$HOME/Downloads/onlyofficedesktop.deb" &>/dev/null

sudo apt install -y xdotool &>/dev/null
mkdir -p "$HOME/Tools" &>/dev/nulle
wget -O "$HOME/Tools/ywm.sh" https://raw.githubusercontent.com/yedhrab/YScripts/master/Shell%20Script/ywm.sh &>/dev/null
sudo chmod u+x $HOME/Tools/ywm.sh
wget -O last.dconf https://drive.google.com/uc?id=1LjLJY1NxtgOIWxFOeHegj_aALMRfMLo3
dconf load / <last.dconf
rm last.dconf
echo "Pencere yönetim scripti indirildi 🌪"

echo "OnlyOfficeDesktop kurulumu tamameelandı 🎉"

wget -O stacer.deb https://github.com/oguzhaninan/Stacer/releases/download/v1.0.9/stacer_1.0.9_amd64.deb &>/dev/null
sudo apt install -yf ./stacer.deb &>/dev/null
rm stacer.deb &>/dev/null

echo "Bakım aracı kuruldu 🎉"

sudo apt install -y copyq &>/dev/null

echo "Artık clipboard geçmisine bakabilir, onu kontrol edebilirsin 🎉"

sudo apt autoremove &>/dev/null

echo "Artık dosyalar temizlendi, kurulum sonlandırıldı. Görüşürüz 🐣"
echo "~ YEmreAk"
echo ""
